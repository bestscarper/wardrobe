package Wardrobe::Model;

use Moose;
use Text::CSV;
use Wardrobe::Data::Line;

extends 'KiokuX::Model';

sub BUILDARGS {
    my ($class, %args) = @_;

    $args{extra_args}{create} //= 1;  # force tables to be created if necessary

    return \%args
}

sub import_cat {
    my $class = shift;
    my $db = shift;
    my $fh = shift;

    # TODO: => Uploader class
    my $c = Text::CSV->new( { binary => 1 } )
        or die "Text::CSV failed: ".Text::CSV->error_diag;
    $c->getline($fh);
    while( my $row = $c->getline($fh) ) {
        my $item = Wardrobe::Data::Line->new( { name => $row->[0], category => $row->[1] } );
        $db->store( $item );
    }
}

1;
