#!/usr/bin/perl

package Euler003;

use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use Math::Complex qw(sqrt);

=head1 NAME

Euler003 - This script is to solve the following Euler Problem:

The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?

=head1 SYNOPSYS

Euler003.pm [OPTION]... [PARAMETER]...

=head1 Description

This template is used to get a head start when writing a script.

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
        _restrict => $args{restrict} || 600851475143,
        };
    bless $self, $class;
}

sub set_restrict{ my Euler003 $self=$_[0]; $self->{_restrict}=$_[1];  }

sub get_restrict{ my Euler003 $self=$_[0]; return $self->{_restrict}; }

sub init{
    my Euler003 $self = shift;
}

sub run{
    my Euler003 $self = shift;
    my $number = $self->get_restrict();
    my $largest_prime = 0;
    my $factor;

    while( $largest_prime == 0 ){
        $factor = $self->smallest_factor( $number );
	if( $factor < $number ){
            $number = int($number) / int($factor);
        }
        else{
            $largest_prime = $number;
        }
    }
    return $largest_prime;
}

sub smallest_factor{
    my Euler003 $self = $_[0];
    my $input         = $_[1];
    unless( $input >= 2 ){ die "Number too small\n"; }

    my $divisor = 2;
    my $prime   = 0;

    while( $divisor < ( sqrt( $input ) + 1 ) ){
        if( $input % $divisor == 0 ){
            $prime = $divisor;
            last;
        }
        $divisor = $divisor + 1;
    }

    if( $prime == 0 ){ $prime = $input; }

    return $prime;
}


unless ( caller ){
    my $restrict = '';

    my $options = GetOptions(
        'restrict=i' => \$restrict,
    ) or die "Euler003.pm: Invalid options passed: $0\n";

    my $app = Euler003->new(
        restrict => $restrict,
    );
    
    $app->init();
    $app->run();
}

1;
