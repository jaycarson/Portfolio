#!/usr/bin/python

import argparse
import subprocess
import re
import yaml
from os import listdir, chdir, getcwd, makedirs
from os.path import isfile, join, isdir


class GenerateJobs(object):
    """
    This object reads the jobs from the jobs directory
    located in ../jobs and generates a dsl.groovy script
    which is then read by Jenkins during the seed_job job.
    """
    def __init__(self):
        self._root_dir = getcwd()

        to_roles = './applications/ansible/ansible-jenkins/roles/'
        to_config = 'jenkins-build-jobs/files/config.yml'
        full_path = to_roles + to_config

        self._configs = yaml.load(open(full_path))

        self._debugging = self._configs['Global']['debugging']

        self._branch_folders = []

        self._branches = []

        self._dsl_location = self._configs['Global']['path_to_dsl']
        self._dsl_content = ''
        self._dsl_repo_content = ''
        self._dsl_folder_content = ''

        self._jenkins_location = self._configs['Global']['path_jenkins']

    def __call__(self):
        self.process_repositories()
        self.write_dsl_groovy_file()

    def process_repositories(self):
        repositories = self._configs['repositories']

        for repository in repositories.keys():
            self.process_repository(repositories[repository])

    def process_repository(self, repo):
        if 'jobs' in repo:
            jobs = repo['jobs']
        else:
            print "Warning: There are not jobs in:"
            print repo
            jobs = None

            if 'pipelines' in repo:
                print "Warning: Pipeline in repo with no branches"
            else:
                return

        if 'location' in repo:
            repo_path = repo['location']
        else:
            repo_path = None

        repo_name = self.get_repo_name(repo_path)

        self.add_branches_folder(repo_name)

        all_branches = self.find_all_branches(repo_path, repo_name)

        if 'jobs' in repo:
            self.process_jobs(repo['jobs'], all_branches, repo_name)

        if 'pipelines' in repo:
            self.process_pipelines(repo['pipelines'], all_branches, repo_name)

    def process_jobs(self, jobs, all_branches, repo_name):
        for job in jobs:
            self.process_job(job, all_branches, repo_name)

    def process_job(self, job, all_branches, repo_name):
        if 'location' in job:
            location_path = job['location']
            if location_path.startswith('./'):
                location_path.replace(',/', '')
            job_path = './' + repo_name + '/' + job['location']

            if not isfile(job_path):
                print "Warning: Invalid job path: " + job_path
                return
        else:
            print "Warning: There is no path to the job:"
            print job
            return

        if 'replacements' in job:
            replacements = job['replacements']
        else:
            replacements = None

        if 'branches' in job:
            if 'all' in job['branches']:
                self.process_job_branches(
                        all_branches,
                        job_path,
                        all_branches,
                        repo_name,
                        replacements,
                    )
            else:
                self.process_job_branches(
                        job['branches'],
                        job_path,
                        all_branches,
                        repo_name,
                        replacements,
                    )
        else:
            self.process_job_branches(
                    all_branches,
                    job_path,
                    all_branches,
                    repo_name,
                    replacements,
                )

    def process_job_branches(
                self,
                branches,
                job_path,
                all_branches,
                repo_name,
                replacements,
            ):
        processed_branches = []

        for branch_pattern in branches:
            for branch in all_branches:
                if branch in processed_branches:
                    continue
                if re.search(branch_pattern, branch) is not None:
                    self.process_job_branch(
                                branch,
                                job_path,
                                repo_name,
                                replacements,
                            )
                    processed_branches.append(branch)

    def process_job_branch(self, branch, job_path, repo_name, replacements):
        self.parse_job_file_for_branch(
                branch,
                job_path,
                repo_name,
                replacements,
            )

        repo_branch = (repo_name, branch)

        if repo_branch not in self._branch_folders:
            self._branch_folders.append(repo_branch)

    def process_pipelines(self, pipelines, all_branches, repo_name):
        for job in pipelines:
            self.process_pipeline(job, all_branches, repo_name)

    def process_pipeline(self, pipeline, all_branches, repo_name):
        if 'jenkinsfile' in pipeline and 'pipelinefile' in pipeline:
            jenkinsfile_path = pipeline['jenkinsfile']
            if jenkinsfile_path.startswith('./'):
                jenkinsfile_path.replace(',/', '')

            pipelinefile_path = pipeline['pipelinefile']
            if pipelinefile_path.startswith('./'):
                pipelinefile_path.replace(',/', '')

            if not isfile(jenkinsfile_path):
                print "Warning: Invalid pipeline path: " + jenkinsfile_path
                return
            if not isfile(pipelinefile_path):
                print "Warning: Invalid pipeline path: " + pipelinefile_path
                return
        else:
            print "Warning: There is no path to the jenkinsfile and/or the pipelinefile:"
            print pipeline
            return

        if 'name' in pipeline:
            pipeline_name = pipeline['name'].replace('_', '-')
        else:
            pipeline_name = 'No-Name'

        if 'variables' in pipeline:
            replacements = job['variables']
        else:
            replacements = None

        if 'branches' in pipeline:
            if 'all' in pipeline['branches']:
                self.process_pipeline_branches(
                        all_branches,
                        pipelinefile_path,
                        jenkinsfile_path,
                        all_branches,
                        repo_name,
                        pipeline_name,
                        replacements,
                    )
            else:
                self.process_pipeline_branches(
                        pipeline['branches'],
                        pipelinefile_path,
                        jenkinsfile_path,
                        all_branches,
                        repo_name,
                        pipeline_name,
                        replacements,
                    )
        else:
            self.process_pipeline_branches(
                    all_branches,
                    pipelinefile_path,
                    jenkinsfile_path,
                    all_branches,
                    repo_name,
                    pipeline_name,
                    replacements,
                )

    def process_pipeline_branches(
                self, branches,
                pipelinefile_path,
                jenkinsfile_path,
                all_branches,
                repo_name,
                pipeline_name,
                replacements,
            ):
        processed_branches = []

        for branch_pattern in branches:
            for branch in all_branches:
                if branch in processed_branches:
                    continue
                if re.search(branch_pattern, branch) is not None:
                    self.process_pipeline_branch(
                            branch,
                            pipelinefile_path,
                            jenkinsfile_path,
                            repo_name,
                            pipeline_name,
                            replacements,
                        )
                    processed_branches.append(branch)

    def process_pipeline_branch(
                self,
                branch,
                pipelinefile_path,
                jenkinsfile_path,
                repo_name,
                pipeline_name,
                replacements,
            ):
        pipeline_content = self.parse_pipeline_file_for_branch(
                                branch,
                                pipelinefile_path,
                                jenkinsfile_path,
                                repo_name,
                                replacements,
                            )

        repo_branch = (repo_name, branch)

        if repo_branch not in self._branch_folders:
            self._branch_folders.append(repo_branch)

        self.create_pipeline_job_directory(branch, repo_name, pipeline_name)
        self.add_pipeline_config_file(branch, repo_name, pipeline_name, pipeline_content)

    def create_pipeline_job_directory(self, branch, repo_name, pipeline_name):
        path_job = join(
                        self._jenkins_location, 'jobs',
                        repo_name, 'jobs',
                        branch.lower(), 'jobs',
                        pipeline_name,
                    )

        if not isdir(path_job):
            makedirs(path_job)

    def add_pipeline_config_file(self, branch, repo_name, pipeline_name, pipeline_content):
        path_to_config = join(
                        self._jenkins_location, 'jobs',
                        repo_name, 'jobs',
                        branch.lower(), 'jobs',
                        pipeline_name,
                    )

        path_with_config = join(path_to_config, 'config.xml')

        if not isdir(path_to_config):
            print "Invalid Path: " + path_to_config
            return

        with open(path_with_config, 'w') as file_handle:
            file_handle.write(pipeline_content)

    def find_all_branches(self, repo_path, repo_name):
        self.clone_repo(repo_path, repo_name)
        return self.get_branches_from_repository(repo_name)

    def get_repo_name(self, repo_path):
        repo_path_pieces = repo_path.split('/')
        repo_name = repo_path_pieces[-1]
        return repo_name.split('.')[0]

    def clone_repo(self, repo, repo_name=None):
        try:
            output = subprocess.check_output(['git', 'clone', repo])
            print output
        except:
            if isdir('./' + repo_name):
                chdir('./' + repo_name)

                output = subprocess.check_output(['git', 'pull'])
                print output

                chdir(self._root_dir)

    def get_branches_from_repository(self, repo_name):
        chdir('./' + repo_name)

        branch_list = []

        branches = subprocess.check_output(['git', 'branch', '-a']).split("\n")
        for branch in branches:
            clean_branch = re.sub(r'^\s*\**\s*', "", branch).strip()
            clean_branch = clean_branch.replace('remotes/origin/', '')
            if (len(clean_branch) > 0 and
                clean_branch not in self._branches and
                ' -> ' not in clean_branch
                ):
                branch_list.append(clean_branch)

        if self._debugging > 0:
            print "========== Branches ================"
            print branch_list
            print "========== REPO:"
            print "    " + repo_name

        for branch in branch_list:
            self.checkout_branch(branch)
            self.add_branch_folder(repo_name, branch)

        self.checkout_branch('master')

        chdir(self._root_dir)

        return branch_list

    def parse_job_file_for_branch(
                self,
                branch,
                job_path,
                repo_name,
                replacements,
            ):
        if self._debugging > 2:
            print "        parse_job_file_for_branch: branch: " + branch
            print "        parse_job_file_for_branch: job_path: " + job_path
            print "        parse_job_file_for_branch: repo_name: " + repo_name

        location = job_path
        header_flag = False

        with open(location, 'r') as file_handle:
            job_file = file_handle.readlines()
            dsl_content = ''
            header_flag = False

            for line in job_file:
                if '[HEADER:START]' in line.upper():
                    header_flag = True
                elif '[HEADER:END]' in line.upper():
                    header_flag = False

                if header_flag:
                    self.parse_header_line(line)
                else:
                    dsl_content += self.parse_line(
                            line,
                            branch,
                            repo_name,
                            replacements,
                        )

            self.add_dsl_content(dsl_content)

    def parse_pipeline_file_for_branch(
                self,
                branch,
                pipelinefile_path,
                jenkinsfile_path,
                repo_name,
                replacements,
            ):
        if self._debugging > 2:
            print "       parse_pipeline_file_for_branch: branch: " + branch
            print "       parse_pipeline_file_for_branch: pipelinefile_path: " + pipelinefile_path
            print "       parse_pipeline_file_for_branch: jenkinsfile_path: " + jenkinsfile_path
            print "       parse_pipeline_file_for_branch: repo_name: " + repo_name

        location = pipelinefile_path

        with open(location, 'r') as file_handle:
            pipeline_file = file_handle.readlines()
            pipeline_content = ''

            for line in pipeline_file:
                pipeline_content += self.parse_line(
                                        line,
                                        branch,
                                        repo_name,
                                        replacements,
                                        pipelinefile_path,
                                    )

        return pipeline_content

    def parse_header(self, line):
        return 1

    def parse_line(
                self,
                newline,
                branch,
                repo_name,
                replacements,
                pipelinefile_path = None,
            ):
        for repository in self._configs['repositories'].keys():
            flag = '{{' + repository.upper() + '}}'
            value = "'" + self._configs['repositories'][repository]['location'] + "'"
            newline = newline.replace(flag, value)

        for replacer in self._configs['variables'].keys():
            flag = replacer
            value = self._configs['variables'][replacer]
            newline = newline.replace(flag, value)

        if replacements is not None:
            for replacement in replacements.keys():
                flag = replacement
                value = replacements[replacement]
                newline = newline.replace(flag, value)

        if newline.startswith('job('):
            newline = newline.replace('{{BRANCH}}', branch.replace('/', '-'))
        else:
            newline = newline.replace('{{BRANCH}}', branch)

        newline = newline.replace('{{REPO}}', repo_name)

        default_path = repo_name + '/' + branch.lower()
        newline = newline.replace('{{DEFAULT_PATH}}', default_path)

        if pipelinefile_path is not None:
            newline = newline.replace('{{JENKINSFILE}}', pipelinefile_path)

        return newline

    def add_branches_folder(self, repo_name):
        if self._debugging > 2:
            print "       add_branches_folder: repo: " + repo_name

        dsl_content_repo = (
            "folder('" + repo_name + "') {\n"
            "    displayName('" + repo_name + "')\n"
            "    description('Folder for branch the repo')\n"
            "}\n"
        )

        self.add_dsl_repo_content(dsl_content_repo)

    def add_branch_folder(self, repo_name, branch):
        if self._debugging > 2:
            print "        add_branch_folder: repo: " + repo_name
            print "        add_branch_folder: branch: " + branch

        branch = branch.replace('/', '-')
        location = "branch " + branch + " in the " + repo_name + " Repo"
        dsl_content = (
            "folder('" + repo_name + '/' + branch.lower() + "') {\n"
            "    displayName('" + branch + "')\n"
            "    description('Folder for " + location + ".')\n"
            "}\n"
        )

        self.add_dsl_folder_content(dsl_content)

    def add_dsl_repo_content(self, content):
        self._dsl_repo_content += content + "\n"

    def add_dsl_folder_content(self, content):
        self._dsl_folder_content += content + "\n"

    def add_dsl_content(self, content):
        self._dsl_content += content + "\n"

    def write_dsl_groovy_file(self):
        if self._debugging > 4:
            print "=============================="
            print "DSL Content:"
            print "=============================="
            print self._dsl_content
            print "=============================="

        full_content = (
                self._dsl_repo_content +
                self._dsl_folder_content +
                self._dsl_content
            )

        with open(self._dsl_location, 'w') as file_handle:
            file_handle.write(full_content)

    def checkout_branch(self, branch):
        subprocess.call('git checkout ' + branch, shell=True)


if __name__ == "__main__":
    python_app = GenerateJobs()
    python_app()
