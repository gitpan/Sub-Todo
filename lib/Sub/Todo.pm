package Sub::Todo;

use warnings;
use strict;
use Carp;

use version; our $VERSION = qv('0.0.1');

use base qw(Exporter);
our @EXPORT      = qw(todo);
our @EXPORT_OK   = qw(todo_return todo_carp todo_croak);
our %EXPORT_TAGS = ( 'all' => [@EXPORT, @EXPORT_OK], 'long' => \@EXPORT_OK );

sub todo {
	$! = 78, return; 
}

sub todo_return {
	$! = 78, return; 
}

sub todo_carp {
	# $! = 78, warn($!), return;
	$! = 78, carp("$!"), $! = 78, return; # carp/croak needs the double quotes and double assignment of $!, warn/die does not, weird...
}

sub todo_croak {
	# $! = 78, die($!), return;
	$! = 78, croak("$!"), $! = 78, return; # still 'return;' just in case they've overidden croak()/handlers with funny things
}

1; 

__END__

=head1 NAME

Sub::Todo - mark subroutines or methods as 'TODO'

=head1 VERSION

This document describes Sub::Todo version 0.0.1

=head1 SYNOPSIS

    use Sub::Todo;

    sub foo {
	    return 'foo';
    }

    sub bar {
	    goto &todo; 
    }

    *baz = \&todo_croak;

Then in your app:

   bar() or die "bar() failed: $!";  
   baz();

Which reminds you "oh yeah, we need to do this still"

=head1 DESCRIPTION

At times you want to/need to/should write the flow of logic without having to break to create the 
actual functions or methods being used. You can create them as temporary 'TODO's by goto()ing 
any of these 'todo' utilities (see INTERFACE).

=head1 EXPORT

todo() is exported by default, the rest can be exported, ':all' will export 
them all, ':long' will export the "long" disambiguously named functions.

=head1 INTERFACE 

These are made to be used with goto() (see SYNOPSIS). They set $! and 'return;'

=head2 todo()

set $! and return

=head2 todo_return()

Same as todo() but the name is more descriptive

=head2 todo_carp()

Same as todo() but it additionally 'carp $!;'

=head2 todo_croak()

Same as todo() but it additionally 'croak $!;'

=head1 DIAGNOSTICS

Throws no real errors or warnings of its own. Except todo_carp() and todo_croak() which throw $!

=head1 CONFIGURATION AND ENVIRONMENT

Sub::Todo requires no configuration files or environment variables.

=head1 DEPENDENCIES

None.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-sub-todo@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 AUTHOR

Daniel Muey  C<< <http://drmuey.com/cpan_contact.pl> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2007, Daniel Muey C<< <http://drmuey.com/cpan_contact.pl> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.