#!/usr/bin/ruby

require 'optparse'
require 'ostruct'

# == NAME
#
#   Euler009 - This is a script which works out the solution of a Euler
#   problem.
#
# == SYNOPSYS
#
#   Euler009.pm [OPTION]... [PARAMETER]...
#
# == DESCRIPTION
#
#   Euler Problem 009:
#
#   A Pythagorean triplet is a set of three natural numbers, a < b < c, for
#   which, a^2 + b^2 = c^2
#
#   For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
#
#   There exists exactly one Pythagorean triplet for which a + b + c = 1000.
#   Find the product abc.
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
class Euler009
    def initialize( restrict_1 )
        @restrict = restrict_1.to_i
    end

    def run
        x = 1
        y = 1
        z = 0

        return_answer = 0

        while x < 1000 do
            y = x + 1

            while y < 1000 do
                z = Math.sqrt(x * x + y * y)

                if is_answer(x, y, z)
                    return_answer = x * y * z
                    break
                end
                y += 1
            end
            x += 1
        end

        return return_answer
    end

    def is_answer(x, y, z)
        if(
            is_natural(x, y, z) and
            is_ascending(x, y, z) and
            is_summed_to(x, y, z)
        )
            return true
        else
            return false
        end
    end

    def is_natural(x, y, z)
        if x.to_i * x.to_i + y.to_i * y.to_i == z.to_i * z.to_i
            return true
        else
            return false
        end
    end

    def is_ascending(x, y, z)
        if x < y and y < z and x < y
            return true
        else
            return false
        end
    end

    def is_summed_to(x, y, z)
        if x + y + z == @restrict
            return true
        else
            return false
        end
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
