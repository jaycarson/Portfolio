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

// Euler Problem 005:
//
// 2520 is the smallest number that can be divided by each of the numbers
// from 1 to 10 without any remainder.
//
// What is the smallest positive number that is evenly divisible by all
// of the numbers from 1 to 20?


class Euler005 {
    static int calculate(){
        def int possible_answer  = 20; // starting with first multiple of 20
        def boolean answer_found = false;

        while( answer_found == false ){
            possible_answer = possible_answer + 20;
            answer_found = is_solution( possible_answer );
        }

        return possible_answer;
    }

    static boolean is_solution( int input ){
        // Starting from 11 because all numbers below 11 are factors of
        // the numbers above 11.
        def int start      = 11;
        def int end        = 20;
        def int divisor    = start;
        def boolean answer = true;

        while( divisor <= end ){
            if( input % divisor != 0 ){
                answer = false;
                break;
            }
            divisor++;
        }

        return answer;
    }

    static void main(String[] args) {}
}
