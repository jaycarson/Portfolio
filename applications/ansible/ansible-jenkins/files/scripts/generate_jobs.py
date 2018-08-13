#!/usr/bin/python

import argparse
import subprocess
import re
import yaml
from os import listdir
from os.path import isfile, join


class GenerateJobs(object):
    """
    This object reads the jobs from the jobs directory
    located in ../jobs and generates a dsl.groovy script 
    which is then read by Jenkins during the seed_job job.
    """
    def __init__(self):
        to_roles = './applications/ansible/ansible-jenkins/roles/'
        to_config = 'jenkins-build-jobs/files/config.yml'
        full_path = to_roles + to_config

        self._configs = yaml.load(full_path)

        print self._configs

        self._debugging = self._configs['debugging']
        
        self._path_to_jobs = self._configs['path_to_jobs']
       
        self._jobs = []
        self._branches = []
        
        self._dsl_location = self._configs['path_to_dsl']
        self._dsl_content = ''

    def __call__(self):
        self.find_all_branches()
        self.find_all_job_files()
        self.add_branches_folder()
        self.parse_job_files()
        self.write_dsl_groovy_file()

    def find_all_branches(self):
        for repo in self._configs['repositories'].keys():
            if repo == 'jenkins_config':
                continue
            else:
                repo_path = self._configs['repositories'][repo]
                repo_name = self.get_repo_name(repo_path)
                self.clone_repo(repo_name)
                self.get_branches_from_repository(repo_name)

    def get_repo_name(self, repo_path):
        repo_path_pieces = repo_path.split('/')
        repo_name = repo_path_pieces[-1]
        return repo_name.split('.')[0]

    def clone_repo(self, repo):
        output = subprocess.check_output(['git', 'clone', repo])
        print output

    def get_branches_from_repository(self, repo):
        os.chdir('./' + repo)
        branches = subprocess.check_output(['git', 'branch', '-a']).split("\n")
        for branch in branches:
            clean_branch = re.sub(r'^\s*\**\s*', "", branch).strip()
            clean_branch = clean_branch.replace('remotes/origin/', '')
            if (len(clean_branch) > 0 and
                clean_branch not in self._branches and
                ' -> ' not in clean_branch
                ):
                self._branches.append(clean_branch)

        if self._debugging:
            print "========== Branches ================" 
            print self._branches

        for branch in self._branches:
            self.checkout_branch(branch)
            self.add_branch_folder(branch)

        self.checkout_branch('master')

        os.chdir('..')

    def find_all_job_files(self):
        for job_file in listdir(self._path_to_jobs):
            if isfile(join(self._path_to_jobs, job_file)):
                self._jobs.append(job_file)

    def parse_job_files(self):
        for job in self._jobs:
            self.parse_job_file_for_each_branch(job)

    def parse_job_file_for_each_branch(self, job):
        for branch in self._branches:
            self.parse_job_file_for_branch(branch, job)

    def parse_job_file_for_branch(self, branch, job):
        location = self._path_to_jobs + job
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
                    dsl_content += self.parse_line(line, branch)
    
            self.add_dsl_content(dsl_content)

    def parse_header(self, line):
        return 1

    def parse_line(self, newline, branch):
        for repository in self._configs['repositories'].keys():
            flag = '{{' + repository.upper() + '}}'
            value = self._configs['repositories'][repository]
            newline = newline.replace(flag, value)
        
        for replacer in self._configs['job_replacements'].keys():
            flag = '{{' + replacer.upper() + '}}'
            value = self._configs['job_replacements'][replacer]
            newline = newline.replace(flag, value)
        
        if newline.startswith('job('):
            newline = newline.replace('{{BRANCH}}', branch.replace('/', '-'))
        else:
            newline = newline.replace('{{BRANCH}}', branch)
        
        return newline

    def add_branches_folder(self):
        dsl_content = (
            "folder('branches') {\n"
            "    displayName('Branches')\n"
            "    description('Folder for branch all of the branches')\n"
            "}\n"
        )

        self.add_dsl_content(dsl_content)

    def add_branch_folder(self, branch):
        branch = branch.replace('/', '-')
        dsl_content = (
            "folder('Branches/" + branch.lower() + "') {\n"
            "    displayName('" + branch + "')\n"
            "    description('Folder for branch " + branch + "')\n"
            "}\n"
        )

        self.add_dsl_content(dsl_content)

    def add_dsl_content(self, content):
        self._dsl_content += content + "\n"

    def write_dsl_groovy_file(self):
        #if self._debugging:
        if False:
            print "=============================="
            print "DSL Content:"
            print "=============================="
            print self._dsl_content
            print "=============================="

        with open(self._dsl_location, 'w') as file_handle:
            file_handle.write(self._dsl_content)

    def checkout_branch(self, branch):
        subprocess.call('git checkout ' + branch, shell=True)


if __name__ == "__main__":
    python_app = GenerateJobs()
    python_app()
