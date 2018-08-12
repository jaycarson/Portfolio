#!/usr/bin/python3

import argparse
import math


class Euler003(object):
    """
    Euler003 - This script is to solve the following Euler Problem:

    The prime factors of 13195 are 5, 7, 13 and 29.

    What is the largest prime factor of the number 600851475143 ?
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
        number = self.restrict
        largest_prime = 0
        factor = 0

        while largest_prime == 0:
            factor = self.smallest_factor(number)

            if factor < number:
                number = int(number) / int(factor)
            else:
                largest_prime = number

        return largest_prime

    def smallest_factor(self, input_value):
        if input_value < 2:
            print("Number too small\n")

        divisor = 2
        prime = 0

        while(divisor < (math.sqrt(input_value) + 1)):
            if(input_value % divisor == 0):
                prime = divisor
                break
            divisor += 1

        if prime == 0:
            prime = input_value

        return prime


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "restrict",
        type=int,
        help="an integer parameter used to restrict the Euler calculation"
    )
    args = parser.parse_args()
    parser.parse_args()

    python_app = Euler003()
    print(str(python_app(args.restrict)))
