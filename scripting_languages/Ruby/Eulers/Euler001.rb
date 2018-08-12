#!/usr/bin/ruby

require 'optparse'
require 'ostruct'

# == NAME
#
#   Euler001 - This is a script which works out the solution of a Euler
#   problem.
#
# == SYNOPSYS
#
#   Euler001.pm [OPTION]... [PARAMETER]...
#
# == DESCRIPTION
#
#   Euler Problem 001:
#
#   If we list all the natural numbers below 10 that are multiples 
#   of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
#   Find the sum of all the multiples of 3 or 5 below 1000.
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
class Euler001
    def initialize( restrict_1 )
        @restrict = restrict_1.to_i
    end

    def run
        answer = 0;
        x      = 0;

        while x < @restrict do
            if( x % 3 == 0 or x % 5 == 0 )
                answer += x;
            end
            x += 1
        end
        return answer
    end
end


if __FILE__ == $0

    options = OpenStruct.new

    OptionParser.new do |opt|
        opt.on('-r', '--restrict RESTRICTION', 'The primary restriction for this Euler Problem')  { |o| options.restrict = o }
    end.parse!

    euler = Euler001.new( options.restrict )
    euler.run()

end
