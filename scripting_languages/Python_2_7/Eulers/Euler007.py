#!/usr/bin/python

import argparse
import math


class Euler007(object):
    """
    Euler007 - This script is to solve the following Euler Problem:

    By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we
    can see that the 6th prime is 13.

    What is the 10,001st prime number?

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
        current_prime_count = 0
        current_number = 0
        prime_count = self.restrict

        while current_prime_count < prime_count:
            current_number += 1

            if self.is_prime(current_number):
                current_prime_count += 1

        return current_number

    def is_prime(self, input_value):
        return_value = False

        if input_value <= 1:
            return_value = False
        elif input_value < 10:
            if(
                (input_value == 2) or
                (input_value == 3) or
                (input_value == 5) or
                (input_value == 7)
            ):
                return_value = True
            else:
                return_value = False
        elif(input_value % 2 == 0):
            return_value = 0
        else:
            return_value = self.is_complicated_prime(input_value)

        return return_value

    def is_complicated_prime(self, input_value):
        divisor = 3
        return_value = True

        while divisor < (math.sqrt(input_value) + 1):
            if(input_value % divisor == 0):
                return_value = False
                break
            divisor += 2

        return return_value


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "restrict",
        type=int,
        help="an integer parameter used to restrict the Euler calculation"
    )
    args = parser.parse_args()
    parser.parse_args()

    python_app = Euler007()
    print str(python_app(args.restrict))
