#!/usr/bin/ruby

require 'optparse'
require 'ostruct'

# == NAME
#
#   Euler003 - This is a script which works out the solution of a Euler
#   problem.
#
# == SYNOPSYS
#
#   Euler003.pm [OPTION]... [PARAMETER]...
#
# == DESCRIPTION
#
#   Euler003 - This script is to solve the following Euler Problem:
#
#   The prime factors of 13195 are 5, 7, 13 and 29.
#
#   What is the largest prime factor of the number 600851475143 ?
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
class Euler003
    def initialize( restrict_1 )
        @restrict = restrict_1.to_i
    end

    def run
        number = @restrict
        largest_prime = 0
        factor = 0

        while largest_prime == 0 do
            factor = smallest_factor(number)

            if factor < number
                number = number.to_i / factor.to_i
            else
                largest_prime = number
            end
        end

        return largest_prime
    end

    def smallest_factor(input_value)
        if input_value < 2
            print "Number too small\n"
        end

        divisor = 2
        prime = 0

        while(divisor < (Math.sqrt(input_value) + 1)) do
            if(input_value % divisor == 0)
                prime = divisor
                break
            end
            divisor += 1
        end

        if prime == 0
            prime = input_value
        end

        return prime
    end
end


if __FILE__ == $0

    options = OpenStruct.new

    OptionParser.new do |opt|
        opt.on('-r', '--restrict RESTRICTION', 'The primary restriction for this Euler Problem')  { |o| options.restrict = o }
    end.parse!

    euler = Euler003.new( options.restrict )
    euler.run()

end
