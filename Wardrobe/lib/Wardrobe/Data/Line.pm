package Wardrobe::Data::Line;

use Moo;
use Types::Standard qw(Str);

has name => (
    is => 'rw',
    isa => Str,
    required => 1
);

has category => (
    is => 'rw',
    isa => Str,
    required => 1
);

1;

