#!/usr/bin/ruby

require 'optparse'
require 'ostruct'

# == NAME
#
#   RubyTemplate - This is base template Ruby script that I use to get
#   a head start on problems.
#
# == SYNOPSYS
#
#   RubyTemplate.pm [OPTION]... [PARAMETER]...
#
# == DESCRIPTION
#
#   This template is used to get a head start when writing a script.
#
# == OPTIONS
#
#   option_1
#
#       This is option 1.
#
#   option_2
#
#       This is option 2.
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
class RubyTemplate
    def initialize( param_1 = 1, param_2 = "two" )
        @var_1 = param_1
        @var_2 = param_2
    end

    def run
        puts "You gave the following command line options:"
        puts "    Option 1: #@var_1"
        puts "    Option 2: #@var_2"
    end
end


if __FILE__ == $0

    options = OpenStruct.new

    OptionParser.new do |opt|
        opt.on('-1', '--option_1 OPTION_1', 'The first option')  { |o| options.option_1 = o }
        opt.on('-2', '--option_2 OPTION_2', 'The second option') { |o| options.option_2 = o }
    end.parse!

    template = RubyTemplate.new( options.option_1, options.option_2 )
    template.run()

end
