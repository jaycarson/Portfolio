#!/usr/bin/perl

package Euler001;

use strict;
use warnings;

use Getopt::Long qw(GetOptions);

=head1 NAME

Euler001 - This script is to solve the following Euler Problem:

Euler Problem 001:

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.

=head1 SYNOPSYS

Euler001.pm [OPTION]... [PARAMETER]...

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
        _restrict => $args{restrict} || 1000,
        };
    bless $self, $class;
}

sub set_restrict{ my Euler001 $self=$_[0]; $self->{_restrict}=$_[1];  }

sub get_restrict{ my Euler001 $self=$_[0]; return $self->{_restrict}; }

sub init{
    my Euler001 $self = shift;
}

sub run{
    my Euler001 $self = shift;
    my $x      = 0;
    my $answer = 0;

    while ( $x < $self->get_restrict() ){
        if( $x % 3 == 0 || $x % 5 == 0 ){
            $answer = $answer + $x;
        }
        $x = $x + 1;
    }
    return $answer;
}


unless ( caller ){
    my $restrict = '';

    my $options = GetOptions(
        'restrict=i' => \$restrict,
    ) or die "Euler001.pm: Invalid options passed: $0\n";

    my $app = Euler001->new(
        restrict => $restrict,
    );
    
    $app->init();
    $app->run();
}

1;
