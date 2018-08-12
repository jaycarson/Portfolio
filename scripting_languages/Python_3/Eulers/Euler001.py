#!/usr/bin/python3

import argparse


class Euler001(object):
    """
    Euler001 - This script is to solve the following Euler Problem:

    If we list all the natural numbers below 10 that are
    multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of
    these multiples is 23.

    Find the sum of all the multiples of 3 or 5 below 1000.
    """
    def __init__(self):
        """
        Initialize the object. No parameter for initialization
        """

    def __call__(self, input_restriction):
        """
        Implement the call operator.

        Parameters:
            Restrict: an integer parameter used to restrict the
                calculation of the Euler problem.
        """
        self.restrict = input_restriction
        return self.calculate()

    def calculate(self):
        x = 0
        answer = 0

        while x < self.restrict:
            if (x % 3 == 0) or (x % 5 == 0):
                answer += x
            x += 1

        return answer


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "restrict",
        type=int,
        help="an integer parameter used to restrict the Euler calculation"
    )
    args = parser.parse_args()
    parser.parse_args()

    python_app = Euler001()
    print(str(python_app(args.restrict)))
