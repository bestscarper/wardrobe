package Wardrobe;
use Dancer ':syntax';
use Dancer::Request::Upload;
use Wardrobe::Model;

our $VERSION = '0.1';


hook before => sub {
    my $db = Wardrobe::Model->new( dsn => 'db:SQLite:dbname='.WARDROBE_DB );
    var db => $db;
    var dbscope => $db->new_scope;
};

get '/' => sub {
    template 'index';
};

post '/upload' => sub {
    my $fh = request->fh;
    Model->import_cat( $fh );
};

true;
