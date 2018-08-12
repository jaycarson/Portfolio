#!/usr/bin/python

import argparse


class PythonTemplate(object):
    """
    This is the base template Python 2.7.1 script that I will use to a
    head start on problems.
    """
    def __init__(self, param, verbose):
        """
        Initialize the object.

        Parameters:
            param: an integer parameter
            verbose: a boolean flag indicating whether or not verbosity
                is turned on or not.
        """
        self.parameter = param
        self.verbosity = verbose

        if self.verbosity:
            print "Init " + str(self.parameter)

    def __call__(self):
        """
        Implement the call operator.
        """
        if self.verbosity:
            print "Call " + str(self.parameter)

    def get_parameter(self): return self.parameter

    def get_verbose(self): return self.verbosity


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "param",
        type=int,
        help="an integer parameter"
    )
    parser.add_argument(
        "-v",
        "--verbose",
        help="increase output verbosity",
        action="store_true"
    )
    args = parser.parse_args()
    parser.parse_args()

    python_app = PythonTemplate(args.param, args.verbose)
    python_app()
