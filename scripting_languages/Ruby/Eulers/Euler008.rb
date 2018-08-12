#!/usr/bin/ruby

require 'optparse'
require 'ostruct'

# == NAME
#
#   Euler008 - This is a script which works out the solution of a Euler
#   problem.
#
# == SYNOPSYS
#
#   Euler008.pm [OPTION]... [PARAMETER]...
#
# == DESCRIPTION
#
#   Euler008 - This script is to solve the following Euler Problem:
#
#   The four adjacent digits in the 1000-digit number that have the greatest
#   product are 9 x 9 x 8 x 9 = 5832.
#
#   73167176531330624919225119674426574742355349194934
#   96983520312774506326239578318016984801869478851843
#   85861560789112949495459501737958331952853208805511
#   12540698747158523863050715693290963295227443043557
#   66896648950445244523161731856403098711121722383113
#   62229893423380308135336276614282806444486645238749
#   30358907296290491560440772390713810515859307960866
#   70172427121883998797908792274921901699720888093776
#   65727333001053367881220235421809751254540594752243
#   52584907711670556013604839586446706324415722155397
#   53697817977846174064955149290862569321978468622482
#   83972241375657056057490261407972968652414535100474
#   82166370484403199890008895243450658541227588666881
#   16427171479924442928230863465674813919123162824586
#   17866458359124566529476545682848912883142607690042
#   24219022671055626321111109370544217506941658960408
#   07198403850962455444362981230987879927244284909188
#   84580156166097919133875499200524063689912560717606
#   05886116467109405077541002256983155200055935729725
#   71636269561882670428252483600823257530420752963450
#
#   Find the thirteen adjacent digits in the 1000-digit number that have the
#
# == OPTIONS
#
#   -r, --restrict
#
#       This is the primary restriction for this Euler Problem.
#
# == LICENSE
#
#   Copyright 2018 James Carson
#
#   Permission is hereby granted, free of charge, to any person obtaining a
#   copy of this software and associated documentation files (the "Software"),
#   to deal in the Software without restriction, including without limitation
#   the rights to use, copy, modify, merge, publish, distribute, sublicense,
#   and/or sell copies of the Software, and to permit persons to whom the
#   Software is furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included
#   in all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
class Euler008
    def initialize( restrict_1 )
        @restrict = restrict_1.to_i
        @start_index = 0
        @big_number = (
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
    end

    def run
        adjacent_count = @restrict
        current_index = @start_index
        end_index = @big_number.length - adjacent_count
        return_answer = 0

        while current_index < end_index do
            product = self.get_product_of_numbers(
                current_index,
                current_index + adjacent_count
            )
            if product > return_answer
                return_answer = product
            end

            current_index += 1
        end

        return return_answer
    end

    def get_product_of_numbers(start, ending)
        current = start
        product = 1

        while current < ending do
            current_number = (@big_number[current]).to_i

            if current_number == 0
                product = 0
                break
            end

            product *= current_number
            current += 1
        end

        return product
    end
end


if __FILE__ == $0

    options = OpenStruct.new

    OptionParser.new do |opt|
        opt.on('-r', '--restrict RESTRICTION', 'The primary restriction for this Euler Problem')  { |o| options.restrict = o }
    end.parse!

    euler = Euler005.new( options.restrict )
    euler.run()

end
