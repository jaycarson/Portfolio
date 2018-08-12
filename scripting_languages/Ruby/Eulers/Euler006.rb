#!/usr/bin/ruby

require 'optparse'
require 'ostruct'

# == NAME
#
#   Euler006 - This is a script which works out the solution of a Euler
#   problem.
#
# == SYNOPSYS
#
#   Euler006.pm [OPTION]... [PARAMETER]...
#
# == DESCRIPTION
#
#   Euler006 - This script is to solve the following Euler Problem:
#
#   The sum of the squares of the first ten natural numbers is,
#   1^2 + 2^2 + ... + 10^2 = 385
#
#   The square of the sum of the first ten natural numbers is,
#   (1 + 2 + ... + 10)^2 = 552 = 3025
#
#   Hence the difference between the sum of the squares of the first ten
#   natural numbers and the square of the sum is 3025 - 385 = 2640.
#
#   Find the difference between the sum of the squares of the first one
#   hundred natural numbers and the square of the sum.
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
class Euler006
    def initialize( restrict_1 )
        @restrict = restrict_1.to_i
    end

    def run
        start = 1
        ending = @restrict

        return (
            square_of_sums(start, ending) -
            sum_of_squares(start, ending)
        )
    end

    def sum_of_squares(start, ending)
        x = start
        return_sum = 0

        while x <= ending do
            return_sum = return_sum + (x * x)
            x += 1
        end

        return return_sum
    end

    def square_of_sums(start, ending)
        x = start
        return_sum = 0

        while x <= ending do
            return_sum += x
            x += 1
        end

        return return_sum * return_sum
    end
end


if __FILE__ == $0

    options = OpenStruct.new

    OptionParser.new do |opt|
        opt.on('-r', '--restrict RESTRICTION', 'The primary restriction for this Euler Problem')  { |o| options.restrict = o }
    end.parse!

    euler = Euler006.new( options.restrict )
    euler.run()

end
