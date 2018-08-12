#!/usr/bin/python3

import argparse
import math


class Euler008(object):
    """
    Euler008 - This script is to solve the following Euler Problem:

    The four adjacent digits in the 1000-digit number that have the greatest
    product are 9 x 9 x 8 x 9 = 5832.

    73167176531330624919225119674426574742355349194934
    96983520312774506326239578318016984801869478851843
    85861560789112949495459501737958331952853208805511
    12540698747158523863050715693290963295227443043557
    66896648950445244523161731856403098711121722383113
    62229893423380308135336276614282806444486645238749
    30358907296290491560440772390713810515859307960866
    70172427121883998797908792274921901699720888093776
    65727333001053367881220235421809751254540594752243
    52584907711670556013604839586446706324415722155397
    53697817977846174064955149290862569321978468622482
    83972241375657056057490261407972968652414535100474
    82166370484403199890008895243450658541227588666881
    16427171479924442928230863465674813919123162824586
    17866458359124566529476545682848912883142607690042
    24219022671055626321111109370544217506941658960408
    07198403850962455444362981230987879927244284909188
    84580156166097919133875499200524063689912560717606
    05886116467109405077541002256983155200055935729725
    71636269561882670428252483600823257530420752963450

    Find the thirteen adjacent digits in the 1000-digit number that have the
    greatest product. What is the value of this product?
    """
    def __init__(self):
        """
        Initialize the object. No parameter for initialization
        """
        self._big_number = (
            '73167176531330624919225119674426574742355349194934' +
            '96983520312774506326239578318016984801869478851843' +
            '85861560789112949495459501737958331952853208805511' +
            '12540698747158523863050715693290963295227443043557' +
            '66896648950445244523161731856403098711121722383113' +
            '62229893423380308135336276614282806444486645238749' +
            '30358907296290491560440772390713810515859307960866' +
            '70172427121883998797908792274921901699720888093776' +
            '65727333001053367881220235421809751254540594752243' +
            '52584907711670556013604839586446706324415722155397' +
            '53697817977846174064955149290862569321978468622482' +
            '83972241375657056057490261407972968652414535100474' +
            '82166370484403199890008895243450658541227588666881' +
            '16427171479924442928230863465674813919123162824586' +
            '17866458359124566529476545682848912883142607690042' +
            '24219022671055626321111109370544217506941658960408' +
            '07198403850962455444362981230987879927244284909188' +
            '84580156166097919133875499200524063689912560717606' +
            '05886116467109405077541002256983155200055935729725' +
            '71636269561882670428252483600823257530420752963450'
        )
        self._start_index = 0

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
        adjacent_count = self.restrict
        current_index = self._start_index
        end_index = len(self._big_number) - adjacent_count
        return_answer = 0

        while current_index < end_index:
            product = self.get_product_of_numbers(
                current_index,
                current_index + adjacent_count
            )
            if product > return_answer:
                return_answer = product

            current_index += 1

        return return_answer

    def get_product_of_numbers(self, start, end):
        current = start
        product = 1

        while current < end:
            current_number = int(self._big_number[current])

            if current_number == 0:
                product = 0
                break

            product *= current_number
            current += 1

        return product


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "restrict",
        type=int,
        help="an integer parameter used to restrict the Euler calculation"
    )
    args = parser.parse_args()
    parser.parse_args()

    python_app = Euler008()
    print(str(python_app(args.restrict)))
