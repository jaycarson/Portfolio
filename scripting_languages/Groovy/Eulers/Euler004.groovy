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

// Euler Problem 004:
//
// A palindromic number reads the same both ways. The largest palindrome
// made from the product of two 2-digit numbers is 9009 = 91 × 99.
//
// Find the largest palindrome made from the product of two 3-digit numbers.


class Euler004 {
    static int calculate(){
        def int answer = 0;

        for( int i = 999; i >= 100; i-- ){
            for( int j = 999; j >= 100; j-- ){
                def test_answer = i * j;
                if( is_palindromic( test_answer ) && ( test_answer > answer ) ){
                    answer = test_answer;
                }
            }
        }

        return answer;
    }

    static boolean is_palindromic( int number ){
        def String number_string = number.toString();
        def boolean return_value = false;

        if( number_string.length() == 6 ){
            if(
                ( number_string[0] == number_string[5] ) &&
                ( number_string[1] == number_string[4] ) &&
                ( number_string[2] == number_string[3] )
            ){ return_value = true; }
        }
        else if( number_string.length() == 5 ){
            if(
                ( number_string[0] == number_string[4] ) &&
                ( number_string[1] == number_string[3] )
            ){ return_value = true; }
        }

        return return_value;
    }

    static void main(String[] args) {}
}
