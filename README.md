# NAME

Sub::Rate - Rate based sub dispatcher generator

# SYNOPSIS

    my $rate = Sub::Rate->new( max_rate => 100 );
    $rate->add( 10 => sub { ... } );     # sub1
    $rate->add( 20 => sub { ... } );     # sub2
    $rate->add( default => sub { ... }); # default sub
    
    my $func = $rate->generate;

    # Calling this $func then:
    # sub1 will be called by rate about 10/100 (10%),
    # sub2 will be called by rate about 20/100 (20%),
    # default sub will be called in rest case (70%),
    $func->();
    

# DESCRIPTION

Sub::Rate generates a SUB that will dispatch some SUBs by specified rate.

# CLASS METHODS

## new(%options)

    my $obj = Sub::Rate->new;

Create Sub::Rate object.

Available options are:

- max\_rate => 'Number'

    Max rate. (Default: 100)

- rand\_func => 'CodeRef'

    Random calculate function. Default is:

        sub {
            CORE::rand($_[0]);
        };

    You can change random function to your own implementation by this option.
    `max_rate` is passed as `$_[0]` to this function.

- sort => 'Bool'

## METHODS

## add($rate : Number|Str, $sub :CodeRef)

    $obj->add( 10, sub { ... } );
    $obj->add( 20, sub { ... } );
    $obj->add( 'default', sub { ... } );

Add `$sub` to internal sublist rate by `$rate`.

If `$rate` is not number but "default", then `$sub` is registered as default sub.
If default sub is already registered, it will be replaced.

## generate()

    my $sub = $obj->generate;

Create a new sub that dispatch functions by its rates.

## clear()

    $obj->clear;

Clear all registered functions and default function.

# AUTHOR

Daisuke Murase <typester@cpan.org>

# COPYRIGHT AND LICENSE

Copyright (c) 2012 KAYAC Inc. All rights reserved.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.
