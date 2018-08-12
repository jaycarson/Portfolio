#!/usr/bin/perl

package Euler006;

use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use Math::Complex qw(sqrt);

=head1 NAME

Euler006 - This script is to solve the following Euler Problem:

The sum of the squares of the first ten natural numbers is,
1^2 + 2^2 + ... + 10^2 = 385

The square of the sum of the first ten natural numbers is,
(1 + 2 + ... + 10)^2 = 552 = 3025

Hence the difference between the sum of the squares of the first ten 
natural numbers and the square of the sum is 3025 − 385 = 2640.

Find the difference between the sum of the squares of the first one
hundred natural numbers and the square of the sum.

=head1 SYNOPSYS

Euler006.pm [OPTION]... [PARAMETER]...

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
        _restrict => $args{restrict} || 100,
        };
    bless $self, $class;
}

sub set_restrict{ my Euler006 $self=$_[0]; $self->{_restrict}=$_[1];  }

sub get_restrict{ my Euler006 $self=$_[0]; return $self->{_restrict}; }

sub init{
    my Euler006 $self = shift;
}

sub run{
    my Euler006 $self   = $_[0];
    my $start           = 1;
    my $end             = $self->get_restrict();

    return ( $self->square_of_sums( $start, $end ) - $self->sum_of_squares( $start, $end ) );
}

sub sum_of_squares{
    my Euler006 $self = $_[0];
    my $start         = $_[1];
    my $end           = $_[2];
    my $x             = $start;
    my $return_sum    = 0;

    while( $x <= $end ){
        $return_sum = $return_sum + ( $x * $x );
        $x = $x + 1;
    }

    return $return_sum;
}

sub square_of_sums{
    my Euler006 $self = $_[0];
    my $start         = $_[1];
    my $end           = $_[2];
    my $x             = $start;
    my $return_sum    = 0;

    while( $x <= $end ){
        $return_sum = $return_sum + $x;
        $x = $x + 1;
    }

    return ( $return_sum * $return_sum );
}


unless ( caller ){
    my $restrict = '';

    my $options = GetOptions(
        'restrict=i' => \$restrict,
    ) or die "Euler006.pm: Invalid options passed: $0\n";

    my $app = Euler006->new(
        restrict => $restrict,
    );
    
    $app->init();
    $app->run();
}

1;
