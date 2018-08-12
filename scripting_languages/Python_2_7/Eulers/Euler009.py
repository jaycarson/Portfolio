#!/usr/bin/python

import argparse
import math


class Euler009(object):
    """
    Euler Problem 009:

    A Pythagorean triplet is a set of three natural numbers, a < b < c, for
    which, a^2 + b^2 = c^2

    For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

    There exists exactly one Pythagorean triplet for which a + b + c = 1000.
    Find the product abc.
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
        y = 1
        z = 0

        return_answer = 0

        while x < 1000:
            y = x + 1

            while y < 1000:
                z = math.sqrt(x * x + y * y)

                if self.is_answer(x, y, z):
                    return_answer = x * y * z
                    break
                y += 1
            x += 1

        return return_answer

    def is_answer(self, x, y, z):
        if(
            self.is_natural(x, y, z) and
            self.is_ascending(x, y, z) and
            self.is_summed_to(x, y, z)
        ):
            return True
        else:
            return False

    def is_natural(self, x, y, z):
        x_int = int(x)
        y_int = int(y)
        z_int = int(z)

        if x_int * x_int + y_int * y_int == z_int * z_int:
            return True
        else:
            return False

    def is_ascending(self, x, y, z):
        if x < y and y < z and x < y:
            return True
        else:
            return False

    def is_summed_to(self, x, y, z):
        if x + y + z == self.restrict:
            return True
        else:
            return False


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "restrict",
        type=int,
        help="an integer parameter used to restrict the Euler calculation"
    )
    args = parser.parse_args()
    parser.parse_args()

    python_app = Euler009()
    print str(python_app(args.restrict))
