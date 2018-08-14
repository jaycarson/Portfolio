#!/usr/bin/bash

bash code_check.sh

python -m xmlrunner test || true

coverage run euler.tests || true
coverage xml

rm *.pyc
