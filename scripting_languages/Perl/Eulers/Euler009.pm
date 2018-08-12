#!/usr/bin/perl

package Euler009;

use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use Math::Complex qw(sqrt);

=head1 NAME

Euler009

=head1 SYNOPSYS

Euler009.pm [OPTION]... [PARAMETER]...

=head1 Description

Euler Problem 009:

A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
a^2 + b^2 = c^2

For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.

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

sub set_restrict{ my Euler009 $self=$_[0]; $self->{_restrict}=$_[1];  }

sub get_restrict{ my Euler009 $self=$_[0]; return $self->{_restrict}; }

sub init{
    my Euler009 $self = shift;
}

sub run{
    my Euler009 $self = $_[0];
    my $restrict      = $self->get_restrict();
    my $x             = 1;
    my $y             = 1;
    my $z;
    my $return_answer = 0;

    while( $x < 1000 ){
        $y = $x + 1;

        while( $y < 1000 ){
            $z = sqrt( $x * $x + $y * $y );

            if( $self->is_answer( $x, $y, $z, $restrict ) ){
                $return_answer = $x * $y * $z;
                last;
            }
            $y = $y + 1;
        }
        $x = $x + 1;
    }

    return $return_answer;
}

sub is_answer{
    my Euler009 $self = $_[0];
    my $x             = $_[1];
    my $y             = $_[2];
    my $z             = $_[3];
    my $sum           = $_[4];
    my $return        = 0;

    if(
        $self->is_natural(   $x, $y, $z ) and
        $self->is_ascending( $x, $y, $z ) and
        $self->is_summed_to( $x, $y, $z, $sum)
    ){
        $return = 1;
    }

    return $return;
}

sub is_natural{
    my Euler009 $self = $_[0];
    my $x             = $_[1];
    my $y             = $_[2];
    my $z             = $_[3];
    my $return        = 0;
    
    if(
        ( $x =~ /^\d+$/ ) and
        ( $y =~ /^\d+$/ ) and
        ( $z =~ /^\d+$/ )
    ){
        $return = 1;
    }

    return $return;
}

sub is_ascending{
    my Euler009 $self = $_[0];
    my $x             = $_[1];
    my $y             = $_[2];
    my $z             = $_[3];
    my $return        = 0;
    
    if( $x < $y and $y < $z and $x < $y ){
        $return = 1;
    }
    
    return $return;
}

sub is_summed_to{
    my Euler009 $self = $_[0];
    my $x             = $_[1];
    my $y             = $_[2];
    my $z             = $_[3];
    my $sum           = $_[4];
    my $return        = 0;
    
    if( ( $x + $y + $z ) == $sum ){
        $return = 1;
    }

    return $return;
}


unless ( caller ){
    my $restrict = '';

    my $options = GetOptions(
        'restrict=i' => \$restrict,
    ) or die "Euler009.pm: Invalid options passed: $0\n";

    my $app = Euler009->new(
        restrict => $restrict,
    );
    
    $app->init();
    $app->run();
}

1;
