#!/usr/bin/groovy

// MIT License

// Copyright (c) 2018 James Carson

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// Euler Problem 009:
//
// A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
// a^2 + b^2 = c^2
//
// For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
//
// There exists exactly one Pythagorean triplet for which a + b + c = 1000.
// Find the product abc.


class Euler009 {
    static int calculate( int triplet_sum = 1000 ){
        def int x = 1;
        def int y = 1;
        def int z;
        def int return_answer = 0;

        while( x < 1000 ){
            y = x + 1;

            while( y < 1000 ){
                z = Math.sqrt( x * x + y *y );

                if( is_answer( x, y, z, triplet_sum ) ){
                    return_answer = x * y * z;
                    break;
                }
                ++y;
            }
            ++x;
        }

        return return_answer;
    }

    static boolean is_answer( x, y, z, sum ){
        if( is_natural( x, y, z ) &&
            is_ascending( x, y, z ) &&
            is_summed_to( x, y, z, sum ) ){
            return true;
        }
        else {
            return false;
        }
    }

    static boolean is_natural( x, y, z ){
        def int x_int = (int)x;
        def int y_int = (int)y;
        def int z_int = (int)z;
        
        if( x_int * x_int + y_int * y_int == z_int * z_int ){
            return true;
        }
        else{
            return false;
        }
    }

    static boolean is_ascending( x, y, z ){
        if( x < y && y < z && x < y ){
            return true;
        }
        else {
            return false;
        }
    }

    static boolean is_summed_to( x, y, z, sum ){
        if( x + y + z == sum ){
            return true;
        }
        else{
            return false;
        }
    }

    static void main(String[] args) {}
}
