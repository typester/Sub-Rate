package Sub::Rate::NoMaxRate;
use strict;
use warnings;
use Any::Moose;

use List::Util 'sum';

extends 'Sub::Rate';

before generate => sub {
    my ($self) = @_;

    my $max_rate = sum map { $_->[0] } @{ $self->_func };
    $self->max_rate($max_rate);
};

__PACKAGE__->meta->make_immutable;
