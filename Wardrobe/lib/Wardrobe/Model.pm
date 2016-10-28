package Wardrobe::Model;

use Moose;
use Text::CSV;
use Wardrobe::Data::Line;
use Dancer ':syntax';
use Text::Trim;

extends 'KiokuX::Model';

sub BUILDARGS {
    my ($class, %args) = @_;

    $args{extra_args}{create} //= 1;  # force tables to be created if necessary
    $args{extra_args}{columns} //= [
        name => {
            data_type => 'varchar',
            is_nullable => 0
        }
    ];

    return \%args
}

sub import_cat {
    my $self = shift;
    my $fh = shift;

    my $c = Text::CSV->new( { binary => 1 } )
        or die "Text::CSV failed: ".Text::CSV->error_diag;
    $c->getline($fh);
    while( my $row = $c->getline($fh) ) {
        trim(@$row);
        my $item = Wardrobe::Data::Line->new( { name => $row->[0], category => $row->[1] } );
        $self->store( $item );
    }
}

sub search_query {
    my $self = shift;
    my %params = @_;

    my @results = $self->search( { name => $params{q} } )->all;

    return @results;
}

sub get_all {
    my $self = shift;

    my @results = $self->root_set( { } )->all;

    return @results;
}

sub add_line_to_order {
    my $self = shift;
    my $line_name = shift;

    debug("add line: $line_name");
}

1;

