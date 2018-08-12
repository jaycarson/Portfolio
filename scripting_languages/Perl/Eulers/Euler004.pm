#!/usr/bin/perl

package Euler004;

use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use Math::Complex qw(sqrt);

=head1 NAME

Euler004 - This script is to solve the following Euler Problem:

=head1 SYNOPSYS

Euler004.pm [OPTION]... [PARAMETER]...

=head1 Description

Euler Problem 004:

A palindromic number reads the same both ways. The largest palindrome
made from the product of two 2-digit numbers is 9009 = 91 × 99.

Find the largest palindrome made from the product of two 3-digit numbers.

=head1 OPTIONS

=over 12

=item C<restrict>

This is a numeric parameter used to restrict the calculation. Usage: "perl perl_template.pm restrict=10"

=back

=head1 License

=over 12

Copyright 2018 James Carson

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=back

=cut

sub new{
    my ( $class, %args ) = @_;

    my $self = {
        _restrict => $args{restrict} || 3,
        };
    bless $self, $class;
}

sub set_restrict{ my Euler004 $self=$_[0]; $self->{_restrict}=$_[1];  }

sub get_restrict{ my Euler004 $self=$_[0]; return $self->{_restrict}; }

sub init{
    my Euler004 $self = shift;
}

sub run{
    my Euler004 $self = shift;
    my $answer = 0;
    my $restrict = $self->get_restrict;
    my $i_max = '9' x $restrict;
    my $j_max = '9' x $restrict;
    my $i_min = '1' . ( '0' x ( $restrict - 1 ) );
    my $j_min = '1' . ( '0' x ( $restrict - 1 ) );

    my $i = $i_max;
    my $j = $j_max;

    while( $i >= $i_min ){
        while( $j >= $j_min ){
            my $test_answer = $i * $j;
            if( 
                ( $self->is_palindromic( $test_answer ) ) and
                ( $test_answer > $answer )
            ){
                $answer = $test_answer;
            }
            $j = $j - 1;
        }
        $j = $j_max;
        $i = $i - 1;
    }

    return $answer;
}

sub is_palindromic{
    my Euler004 $self = $_[0];
    my $input         = $_[1];
    my $restrict      = $self->get_restrict();
    my $return_value  = 0;

    if(
        ( substr $input, 0, $restrict ) == reverse ( substr $input, -$restrict, $restrict )
    ){ 
        $return_value = 1;
    }

    return $return_value;
}


unless ( caller ){
    my $restrict = '';

    my $options = GetOptions(
        'restrict=i' => \$restrict,
    ) or die "Euler004.pm: Invalid options passed: $0\n";

    my $app = Euler004->new(
        restrict => $restrict,
    );
    
    $app->init();
    $app->run();
}

1;
