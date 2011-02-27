package Queue::Base;

# ABSTRACT: Simple OO style queue implementation.

use strict;
use warnings;

use Carp;

our $VERSION = '2.1_04';    # VERSION

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

=head1 NAME

Queue::Base - Simple OO style queue implementation.

=head1 VERSION

version 2.1_04

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

=head1 NAME

Queue::Base - Simple OO style queue implementation.

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

This software is copyright (c) 2011 by Farkas Arpad.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__END__
