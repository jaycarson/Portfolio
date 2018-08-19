#!/usr/bin/bash

bash code_check.sh

python -m xmlrunner euler_tests.py || true

coverage run euler_tests.py || true
coverage xml

rm *.pyc
