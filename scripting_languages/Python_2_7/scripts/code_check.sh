#!/usr/bin/bash

# Updade pip just in case you are running an older version of pip
sudo pip install --upgrade pip

# pep8 is being deprecated and replaced by pycodestyle on some future date
sudo pip install pycodestyle

# Run the pycodestyle application on each python script to be analyzed
pycodestyle --first python_template_2_7_1.py
pycodestyle --first python_template_test_suite_2_7_1.py
