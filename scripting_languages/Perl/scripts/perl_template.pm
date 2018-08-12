#!/usr/bin/perl

package PerlTemplate;

use strict;
use warnings;

use Getopt::Long qw(GetOptions);

=head1 NAME

PerlTemplate - This is the base template Perl script that I use to get
a head start on problems.

=head1 SYNOPSYS

PerlTemplate.pm [OPTION]... [PARAMETER]...

=head1 Description

This template is used to get a head start when writing a script.

=head1 OPTIONS

=over 12

=item C<p_string>

This is a string parameter. Usage: "perl perl_template.pm p_string=sting"

=item C<p_bool>

This is a bool parameter. Usage: "perl perl_template.pmp_bool"

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
        _parameter_string => $args{parameter_string} || '',
        _parameter_bool   => $args{parameter_bool}   || undef,
        };
    bless $self, $class;
}

sub set_parameter_string{ my PerlTemplate $self=$_[0]; $self->{_parameter_string}=$_[1];  }
sub set_parameter_bool  { my PerlTemplate $self=$_[0]; $self->{_parameter_bool  }=$_[1];  }

sub get_parameter_string{ my PerlTemplate $self=$_[0]; return $self->{_parameter_string}; }
sub get_parameter_bool  { my PerlTemplate $self=$_[0]; return $self->{_parameter_bool  }; }

sub init{
    my PerlTemplate $self = shift;
}

sub run{
    my PerlTemplate $self = shift;
}


unless ( caller ){
    my $parameter_string = '';
    my $parameter_bool   = undef;

    my $options = GetOptions(
        'p_string=s' => \$parameter_string,
        'p_bool'     => \$parameter_bool,
    ) or die "PerlTemplate.pm: Invalid options passed: $0\n";

    my $app = PerlTemplate->new(
        parameter_string => $parameter_string,
        parameter_bool   => $parameter_bool,
    );
    
    $app->init();
    $app->run();
}

1;
