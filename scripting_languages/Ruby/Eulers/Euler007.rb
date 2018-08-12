#!/usr/bin/ruby

require 'optparse'
require 'ostruct'

# == NAME
#
#   Euler007 - This is a script which works out the solution of a Euler
#   problem.
#
# == SYNOPSYS
#
#   Euler007.pm [OPTION]... [PARAMETER]...
#
# == DESCRIPTION
#
#   Euler007 - This script is to solve the following Euler Problem:
#
#   2520 is the smallest number that can be divided by each of the numbers
#   from 1 to 10 without any remainder.
#
#   What is the smallest positive number that is evenly divisible by all
#   of the numbers from 1 to 20?
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
class Euler007
    def initialize( restrict_1 )
        @restrict = restrict_1.to_i
    end

    def run
        current_prime_count = 0
        current_number = 0
        prime_count = @restrict

        while current_prime_count < prime_count do
            current_number += 1

            if is_prime(current_number)
                current_prime_count += 1
            end
        end

        return current_number
    end

    def is_prime(input_value)
        return_value = false

        if input_value <= 1
            return_value = false
        elsif input_value < 10
            if(
                (input_value == 2) or
                (input_value == 3) or
                (input_value == 5) or
                (input_value == 7)
            )
                return_value = true
            else
                return_value = false
            end
        elsif input_value % 2 == 0
            return_value = false
        else
            return_value = is_complicated_prime(input_value)
        end

        return return_value
    end

    def is_complicated_prime(input_value)
        divisor = 3
        return_value = true

        while divisor < (Math.sqrt(input_value) + 1) do
            if input_value % divisor == 0 then
                return_value = false
                break
            end
            divisor += 2
        end

        return return_value
    end
end


if __FILE__ == $0

    options = OpenStruct.new

    OptionParser.new do |opt|
        opt.on('-r', '--restrict RESTRICTION', 'The primary restriction for this Euler Problem')  { |o| options.restrict = o }
    end.parse!

    euler = Euler007.new( options.restrict )
    euler.run()

end
