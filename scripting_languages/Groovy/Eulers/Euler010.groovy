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

// Euler Problem 010:
//
// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
//
// Find the sum of all the primes below two million.


class Euler010 {
    static long calculate( int max_value = 2000000 ){
        def int x = 1;
        def long return_answer = 0;

        while( x < max_value ){
            if( is_prime( x ) ){
                return_answer += x;
            }
            ++x;
        }

        return return_answer;
    }

    static boolean is_prime( int number ){
        def boolean return_value;

        if( number <= 1 ){
            return_value = false;
        }
        else if( number < 10 ){
            if( ( number == 2 ) ||
                ( number == 3 ) ||
                ( number == 5 ) ||
                ( number == 7 )
            ){
                return_value = true;
            }
            else{
                return_value = false;
            }
        }
        else if( number % 2 == 0 ){
            return_value = false;
        }
        else{
            return_value = is_complicated_prime( number );
        }

        return return_value;
    }

    static boolean is_complicated_prime( int number ){
        def int divisor          = 3;
        def boolean return_value = true;

        while( divisor < ( Math.sqrt( (double)number ) + 1 ) ){
            if( number % divisor == 0 ){
                return_value = false;
                break;
            }
            divisor = divisor + 2;
        }

        return return_value;
    }

    static void main(String[] args) {}
}
