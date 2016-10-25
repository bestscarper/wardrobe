use Test::More tests => 2;
use strict;
use warnings;
use DBD::SQLite;
use Wardrobe::Model;
use Wardrobe::Data::Line;
use Dir::Self;

my $db = Wardrobe::Model->new( dsn => 'dbi:SQLite:dbname=:memory:' );
my $scope = $db->new_scope;

open( my $fh, "<", __DIR__ . "/clothing.csv" )
    or die "Can't open test file";

# for behavioural TDD better to mock 'Wardrobe::Data::Line::new' etc
# and verify that this is called with suitable params
Wardrobe::Model->import_cat( $db, $fh );

close($fh);

my @objs = $db->root_set( { } )->all;
is( scalar(@objs), 9 );

