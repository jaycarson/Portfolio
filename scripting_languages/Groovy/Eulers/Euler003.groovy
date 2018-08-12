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

// Euler Problem 003:
//
// The prime factors of 13195 are 5, 7, 13 and 29.
//
// What is the largest prime factor of the number 600851475143 ?


class Euler003 {
    static int calculate(){
        def long number = 600851475143;
        def int largest_prime = 0;
        def int factor;

        while( largest_prime == 0 ){
	        factor = smallest_factor( number );
		    if( factor < number ){
                number = number.intdiv( factor );
            }
		    else{
                largest_prime = number;
            }
        }
        return largest_prime;
    }

    static int smallest_factor( long input ){
	    assert input >= 2;

        def int divisor = 2;
        def int prime   = 0;

        while( divisor < ( Math.sqrt( (double)input ) + 1 ) ){
            if( input % divisor == 0 ){
                prime = divisor;
                break;
            }
            ++divisor;
        }

        if( prime == 0 ){ prime = input; }

        return prime;
    }

    static void main(String[] args) {}
}
