#!/usr/bin/bash

# Updade pip just in case you are running an older version of pip
sudo pip install --upgrade pip

# pep8 is being deprecated and replaced by pycodestyle on some future date
sudo pip install pycodestyle

# Run the pycodestyle application on each python script to be analyzed
pycodestyle --first Euler001.py
pycodestyle --first Euler002.py
pycodestyle --first Euler003.py
pycodestyle --first Euler004.py
pycodestyle --first Euler005.py
pycodestyle --first Euler006.py
pycodestyle --first Euler007.py
pycodestyle --first Euler008.py
pycodestyle --first Euler009.py
pycodestyle --first Euler010.py
pycodestyle --first euler.tests
