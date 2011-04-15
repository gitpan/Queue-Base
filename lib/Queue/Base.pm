package Queue::Base;

use strict;
use warnings;

# ABSTRACT: Simple OO style queue implementation.

our $VERSION = '2.201'; # VERSION

use Carp;

sub new {
    my ( $class, $elems ) = @_;
    my $self = bless( { list => [] }, $class );

    if ( defined $elems && ref($elems) eq 'ARRAY' ) {
        @{ $self->{list} } = @{$elems};
    }

    return $self;
}

sub add {
    my ( $self, @args ) = @_;
    push @{ $self->{list} }, @args;
    return;
}

sub remove_all {
    my $self = shift;
    return ( $self->remove( $self->size ) );
}

sub remove {
    my $self = shift;
    my $num = shift || 1;

    return shift @{ $self->{list} } unless wantarray;

    croak 'Paramater must be a positive number' unless 0 < $num;

    my @removed = ();

    my $count = $num;
    while ($count) {
        my $elem = shift @{ $self->{list} };
        last unless defined $elem;
        push @removed, $elem;
        $count--;
    }

    return @removed;
}

sub size {
    return scalar( @{ shift->{list} } );
}

sub empty {
    return shift->size == 0;
}

sub clear {
    shift->{list} = [];
    return;
}

1;



=pod

=encoding utf-8

=head1 NAME

Queue::Base - Simple OO style queue implementation.

=head1 VERSION

version 2.201

=head1 SYNOPSIS

    use Queue::Base;

    # construction
    my $queue = new Queue::Base;
    # or
    my $queue = new Queue::Base(\@elements);

    # add a new element to the queue
    $queue->add($element);

    # remove the next element from the queue
    if (! $queue->empty) {
        my $element = $queue->remove;
    }

    # or
    $element = $queue->remove;
    if (defined $element) {
        # do some processing here
    }

    # add/remove more than just one element
    $queue->add($elem1, $elem2 ...)
    # and
    @elements = $queue->remove(5);

=head1 DESCRIPTION

The Queue::Base is a simple implementation for queue structures using an
OO interface. Provides basic functionality: nothing less - nothing more.

=head1 METHODS

=head2 Constructor

=over

=item new [ELEMENTS]

Creates a new empty queue.

ELEMENTS is an array reference with elements the queue to be initialized with.

=back

=head2 Methods

=over

=item add [LIST_OF_ELEMENTS]

Adds the LIST OF ELEMENTS to the end of the queue.

=item remove [NUMBER_OF_ELEMENTS]

In scalar context it returns the first element from the queue.

In array context it attempts to return NUMBER_OF_ELEMENTS requested;
when NUMBER_OF_ELEMENTS is not given, it defaults to 1.

=item remove_all

Returns an array with all the elements in the queue, and clears the queue.

=item size

Returns the size of the queue.

=item empty

Returns whether the queue is empty, which means its size is 0.

=item clear

Removes all elements from the queue.

=back

=head1 CAVEATS

The module works only with scalar values. If you want to use more complex
structures (and there's a big change you want that) please use references,
which in perl5 are basically scalars.

=head1 AUTHOR

Alexei Znamensky <russoz@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Farkas Arpad, Alexei Znamensky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc Queue::Base

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

Search CPAN

L<http://search.cpan.org/dist/Queue-Base>

=item *

AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Queue-Base>

=item *

CPAN Ratings

L<http://cpanratings.perl.org/d/Queue-Base>

=item *

CPAN Forum

L<http://cpanforum.com/dist/Queue-Base>

=item *

CPANTS Kwalitee

L<http://cpants.perl.org/dist/overview/Queue-Base>

=item *

CPAN Testers Results

L<http://cpantesters.org/distro/Q/Queue-Base.html>

=item *

CPAN Testers Matrix

L<http://matrix.cpantesters.org/?dist=Queue-Base>

=back

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://github.com/russoz/Queue-Base/issues>.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see L<http://search.cpan.org/dist/Queue-Base/>.

The development version lives at L<http://github.com/russoz/Queue-Base>
and may be cloned from L<git://github.com/russoz/Queue-Base.git>.
Instead of sending patches, please fork this project using the standard
git and github infrastructure.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT
WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER
PARTIES PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE
SOFTWARE IS WITH YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME
THE COST OF ALL NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE LIABLE
TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE
SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
DAMAGES.

=cut


__END__


