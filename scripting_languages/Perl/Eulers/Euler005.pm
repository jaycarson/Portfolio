#!/usr/bin/perl

package Euler005;

use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use Math::Complex qw(sqrt);

=head1 NAME

Euler005

=head1 SYNOPSYS

Euler005.pm [OPTION]... [PARAMETER]...

=head1 Description

Euler005 - This script is to solve the following Euler Problem:

2520 is the smallest number that can be divided by each of the numbers
from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all
of the numbers from 1 to 20?

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
        _restrict => $args{restrict} || 20,
        };
    bless $self, $class;
}

sub set_restrict{ my Euler005 $self=$_[0]; $self->{_restrict}=$_[1];  }

sub get_restrict{ my Euler005 $self=$_[0]; return $self->{_restrict}; }

sub init{
    my Euler005 $self = shift;
}

sub run{
    my Euler005 $self = shift;
    my $answer        = 0;
    my $answer_found  = 0;
    my $interval      = $self->determine_interval();

    while( $answer_found == 0 ){
        $answer = $answer + $interval;
        $answer_found = $self->is_solution( $answer );
    }

    return $answer;
}

sub determine_interval{
    my Euler005 $self   = $_[0];
    my $restrict        = $self->get_restrict();
    my $possible_prime  = 2;
    my $interval        = 1;
    
    while( $possible_prime <= $restrict ){
        if( $self->is_prime( $possible_prime ) ){
            $interval = $interval * $possible_prime;
        }
        $possible_prime = $possible_prime + 1;
    }

    return $interval;
}

sub is_solution{
    my Euler005 $self   = $_[0];
    my $input           = $_[1];
    my $restrict        = $self->get_restrict();
    my $divisor         = 1;
    my $answer          = 1;

    while( $divisor < $restrict ){
        unless( $input % $divisor == 0 ){ $answer = 0; last; }
        $divisor = $divisor + 1;
    }

    return $answer;
}

sub is_prime{
    my Euler005 $self   = $_[0];
    my $input           = $_[1];
    my $return_value;

    if( $input <= 1 ){
        $return_value = 0;
    }
    elsif( $input < 10 ){
        if( ( $input == 2 ) ||
            ( $input == 3 ) ||
            ( $input == 5 ) ||
            ( $input == 7 )
        ){
            $return_value = 1;
        }
        else{
            $return_value = 0;
        }
    }
    elsif( $input % 2 == 0 ){
        $return_value = 0;
    }
    else{
        $return_value = $self->is_complicated_prime( $input );
    }

    return $return_value;
}

sub is_complicated_prime{
    my Euler005 $self   = $_[0];
    my $input           = $_[1];
    my $divisor         = 3;
    my $return_value    = 1;

    while( $divisor < ( sqrt( $input ) + 1 ) ){
        if( $input % $divisor == 0 ){
            $return_value = 0;
            last;
        }
        $divisor = $divisor + 2;
    }

    return $return_value;
}


unless ( caller ){
    my $restrict = '';

    my $options = GetOptions(
        'restrict=i' => \$restrict,
    ) or die "Euler005.pm: Invalid options passed: $0\n";

    my $app = Euler005->new(
        restrict => $restrict,
    );
    
    $app->init();
    $app->run();
}

1;
