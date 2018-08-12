#!/usr/bin/python3

import argparse
import math


class Euler005(object):
    """
    Euler005 - This script is to solve the following Euler Problem:

    2520 is the smallest number that can be divided by each of the numbers
    from 1 to 10 without any remainder.

    What is the smallest positive number that is evenly divisible by all
    of the numbers from 1 to 20?

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
        answer = 0
        answer_found = False
        interval = self.determine_interval()

        while answer_found is False:
            answer = answer + interval
            answer_found = self.is_solution(answer)

        return answer

    def determine_interval(self):
        possible_prime = 2
        interval = 1

        while possible_prime <= self.restrict:
            if self.is_prime(possible_prime):
                interval = interval * possible_prime
            possible_prime = possible_prime + 1

        return interval

    def is_solution(self, input_value):
        divisor = 2
        answer = True

        while divisor < self.restrict:
            if input_value % divisor != 0:
                answer = False
                break
            divisor += 1

        return answer

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

    python_app = Euler005()
    print(str(python_app(args.restrict)))
