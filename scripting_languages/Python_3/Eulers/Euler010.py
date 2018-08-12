#!/usr/bin/python3

import argparse
import math


class Euler010(object):
    """
    Euler Problem 010:

    The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

    Find the sum of all the primes below two million.
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
        x = 1
        return_answer = 0

        while x < self.restrict:
            if self.is_prime(x):
                return_answer += x
            x += 1

        return return_answer

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

    python_app = Euler010()
    print(str(python_app(args.restrict)))
