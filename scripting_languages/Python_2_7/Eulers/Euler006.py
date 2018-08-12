#!/usr/bin/python

import argparse
import math


class Euler006(object):
    """
    Euler006 - This script is to solve the following Euler Problem:

    The sum of the squares of the first ten natural numbers is,
    1^2 + 2^2 + ... + 10^2 = 385

    The square of the sum of the first ten natural numbers is,
    (1 + 2 + ... + 10)^2 = 552 = 3025

    Hence the difference between the sum of the squares of the first ten
    natural numbers and the square of the sum is 3025 - 385 = 2640.

    Find the difference between the sum of the squares of the first one
    hundred natural numbers and the square of the sum.
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
        start = 1
        end = self.restrict

        return (
            self.square_of_sums(start, end) -
            self.sum_of_squares(start, end)
        )

    def sum_of_squares(self, start, end):
        x = start
        return_sum = 0

        while x <= end:
            return_sum = return_sum + (x * x)
            x += 1

        return return_sum

    def square_of_sums(self, start, end):
        x = start
        return_sum = 0

        while x <= end:
            return_sum += x
            x += 1

        return return_sum * return_sum


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "restrict",
        type=int,
        help="an integer parameter used to restrict the Euler calculation"
    )
    args = parser.parse_args()
    parser.parse_args()

    python_app = Euler006()
    print str(python_app(args.restrict))
