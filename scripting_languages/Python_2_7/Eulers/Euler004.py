#!/usr/bin/python

import argparse
import math


class Euler004(object):
    """
    Euler Problem 004:

    A palindromic number reads the same both ways. The largest palindrome
    made from the product of two 2-digit numbers is 9009 = 91 x 99.

    Find the largest palindrome made from the product of two 3-digit numbers.
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
        i_max = int('9' * self.restrict)
        j_max = int('9' * self.restrict)
        i_min = int('1' + ('0' * (self.restrict - 1)))
        j_min = int('1' + ('0' * (self.restrict - 1)))

        i = i_max
        j = j_max

        while i >= i_min:
            while j >= j_min:
                test_answer = i * j
                if self.is_palindromic(test_answer) and test_answer > answer:
                    answer = test_answer
                j -= 1
            j = j_max
            i -= 1

        return answer

    def is_palindromic(self, input_value):
        input_string = str(input_value)
        return_value = 0
        beginning = input_string[:self.restrict]
        ending = ''.join(reversed(input_string[-self.restrict:]))

        if beginning == ending:
            return_value = 1

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

    python_app = Euler004()
    print str(python_app(args.restrict))
