#!/usr/bin/ruby

require 'optparse'
require 'ostruct'

# == NAME
#
#   Euler004 - This is a script which works out the solution of a Euler
#   problem.
#
# == SYNOPSYS
#
#   Euler004.pm [OPTION]... [PARAMETER]...
#
# == DESCRIPTION
#
#   Euler Problem 004:
#
#   A palindromic number reads the same both ways. The largest palindrome
#   made from the product of two 2-digit numbers is 9009 = 91 x 99.
#
#   Find the largest palindrome made from the product of two 3-digit numbers.
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
class Euler004
    def initialize( restrict_1 )
        @restrict = restrict_1.to_i
    end

    def run
        answer = 0
        i_max = ('9' * @restrict).to_i
        j_max = ('9' * @restrict).to_i
        i_min = ('1' + ('0' * (@restrict - 1))).to_i
        j_min = ('1' + ('0' * (@restrict - 1))).to_i

        i = i_max
        j = j_max

        while i >= i_min
            while j >= j_min
                test_answer = i * j
                if is_palindromic(test_answer) and test_answer > answer
                    answer = test_answer
                end
                j -= 1
            end
            j = j_max
            i -= 1
        end

        return answer
    end

    def is_palindromic(input_value)
        input_string = input_value.to_s
        return_value = false
        beginning = input_string[0..(@restrict - 1)]
        ending = (input_string[-@restrict..-1]).reverse!

        if beginning == ending
            return_value = true
        end

        return return_value
    end
end


if __FILE__ == $0

    options = OpenStruct.new

    OptionParser.new do |opt|
        opt.on('-r', '--restrict RESTRICTION', 'The primary restriction for this Euler Problem')  { |o| options.restrict = o }
    end.parse!

    euler = Euler004.new( options.restrict )
    euler.run()

end
