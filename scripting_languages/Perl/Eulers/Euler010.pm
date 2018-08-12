#!/usr/bin/perl

package Euler010;

use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use Math::Complex qw(sqrt);

=head1 NAME

Euler010

=head1 SYNOPSYS

Euler010.pm [OPTION]... [PARAMETER]...

=head1 Description

Euler Problem 008:

The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.

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
        _restrict => $args{restrict} || 2000000,
        };
    bless $self, $class;
}

sub set_restrict{ my Euler010 $self=$_[0]; $self->{_restrict}=$_[1];  }

sub get_restrict{ my Euler010 $self=$_[0]; return $self->{_restrict}; }

sub init{
    my Euler010 $self = shift;
}

sub run{
    my Euler010 $self = shift;
    my $restrict      = $self->get_restrict();
    my $x             = 1;
    my $return_answer = 0;

    while( $x < $restrict ){
        if( $self->is_prime( $x ) ){
            $return_answer = $return_answer + $x;
        }
        $x = $x + 1;
    }

    return $return_answer;
}

sub is_prime{
    my Euler010 $self   = $_[0];
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
    my Euler010 $self   = $_[0];
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
    ) or die "Euler010.pm: Invalid options passed: $0\n";

    my $app = Euler010->new(
        restrict => $restrict,
    );
    
    $app->init();
    $app->run();
}

1;
