#!/usr/bin/python

import argparse
import subprocess
import re
import yaml
from os import listdir, chdir, getcwd
from os.path import isfile, join


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

        self._path_to_jobs = self._configs['path_to_jobs']

        self._branch_folders = []

        self._jobs = []
        self._branches = []

        self._dsl_location = self._configs['Global']['path_to_dsl']
        self._dsl_content = ''
        self._dsl_repo_content = ''
        self._dsl_folder_content = ''

    def __call__(self):
        self.process_repositories()
        self.write_dsl_groovy_file()

    def process_repositories(self):
        repositories = self._configs['repositories']

        for repository in repositories.keys():
            self.process_repository(repository)

    def process_repository(self, repo):
        if 'jobs' in repo:
            jobs = repo['jobs']
        else:
            print "Warning: There are not jobs in:"
            print repo
            return

        if 'location' in repo:
            repo_path = repo['location']
        else:
            repo_path = None

        repo_name = self.get_repo_name(location)

        self.clone_repo(repo_path)

        self.add_branches_folder(repo_name)

        all_branches = self.find_all_branches(repo_name)

        self.process_jobs(repo['jobs'], all_branches, repo_name)

    def process_jobs(self, jobs, all_branches, repo_name):
        for job in jobs:
            process_job(job, all_branches, repo_name)

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

        if 'branches' in job:
            if 'all' in job['branches']:
                self.process_job_branches(
                        all_branches,
                        job_path,
                        all_branches,
                        repo_name,
                    )
            else:
                self.process_job_branches(
                        job['branches'],
                        job_path,
                        all_branches,
                        repo_name,
                    )
        else:
            self.process_job_branches(
                    all_branches,
                    job_path,
                    all_branches,
                    repo_name,
                )

    def process_job_branches(self, branches, job_path, all_branches, repo_name):
        processed_branches = []

        for branch_pattern in branches:
            for branch in all_branches:
                if branch in processed_branches:
                    continue
                if re.search(branch_patter, branch) is not None:
                    process_job_branch(branch, job_path, repo_name)
                    processed_branches.append(branch)

    def process_job_branch(self, branch, job_path, repo_name):
        self.parse_job_file_for_branch(self, branch, job_path, repo_name)

        repo_branch = (repo_name, branch)

        if repo_branch not in self._branch_folders:
            self._branch_folders.append(repo_branch)

    def find_all_branches(self):
        for repo in self._configs['repositories'].keys():
            repo_path = self._configs['repositories'][repo]['location']
            repo_name = self.get_repo_name(repo_path)
            self.clone_repo(repo_path)
            self.get_branches_from_repository(repo_name)

    def get_repo_name(self, repo_path):
        repo_path_pieces = repo_path.split('/')
        repo_name = repo_path_pieces[-1]
        return repo_name.split('.')[0]

    def clone_repo(self, repo):
        try:
            output = subprocess.check_output(['git', 'clone', repo])
            print output
        except:
            pass

    def get_branches_from_repository(self, repo):
        chdir('./' + repo)
        branches = subprocess.check_output(['git', 'branch', '-a']).split("\n")
        for branch in branches:
            clean_branch = re.sub(r'^\s*\**\s*', "", branch).strip()
            clean_branch = clean_branch.replace('remotes/origin/', '')
            if (len(clean_branch) > 0 and
                clean_branch not in self._branches and
                ' -> ' not in clean_branch
                ):
                self._branches.append(clean_branch)

        if self._debugging > 0:
            print "========== Branches ================"
            print self._branches

        for branch in self._branches:
            self.checkout_branch(branch)
            self.add_branch_folder(branch)

        self.checkout_branch('master')

        chdir(self._root_dir)

    def parse_job_file_for_branch(self, branch, job_path, repo_name):
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
                    dsl_content += self.parse_line(line, branch, repo_name)

            self.add_dsl_content(dsl_content)

    def parse_header(self, line):
        return 1

    def parse_line(self, newline, branch, repo_name):
        for repository in self._configs['repositories'].keys():
            flag = '{{' + repository.upper() + '}}'
            value = "'" + self._configs['repositories'][repository] + "'"
            newline = newline.replace(flag, value)

        for replacer in self._configs['job_replacements'].keys():
            flag = replacer['replace']
            value = replacer['with']
            newline = newline.replace(flag, value)

        if newline.startswith('job('):
            newline = newline.replace('{{BRANCH}}', branch.replace('/', '-'))
        else:
            newline = newline.replace('{{BRANCH}}', branch)
    
        newline = newline.replace('{{REPO}}', repo_name)

        return newline

    def add_branches_folder(self, repo_name):
        dsl_content = (
            "folder('" + repo_name + "/branches') {\n"
            "    displayName('" + repo_name + " Branches')\n"
            "    description('Folder for branch all of the branches')\n"
            "}\n"
        )

        self.add_dsl_repo_content(dsl_content)

    def add_branch_folder(self, repo_name, branch):
        branch = branch.replace('/', '-')
        location = "branch " + branch + " in the " + repo_name + " Repo"
        dsl_content = (
            "folder('" + repo_name + "/branches/" + branch.lower() + "') {\n"
            "    displayName('" + branch + "')\n"
            "    description('Folder for " + location + ".')\n"
            "}\n"
        )

        self.add_dsl_folder_content(dsl_content)

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
