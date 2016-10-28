package Wardrobe;
use Dancer ':syntax';
use Dancer::Request::Upload;
use Dancer::Plugin::Ajax;
use aliased 'Wardrobe::Model';

our $VERSION = '0.1';

use constant WARDROBE_DB => config->{wardrobe}->{database} // "wardrobe.sqlite";

hook before => sub {
    my $db = Model->new( dsn => 'dbi:SQLite:dbname='.WARDROBE_DB );
    var db => $db;
    var dbscope => $db->new_scope;
};

get '/' => sub {
    template 'index';
};

post '/upload' => sub {
    my $upload = request->upload('catalogue');
    my $fh = $upload->file_handle;
    vars->{db}->import_cat( $fh );

    template 'index'
};

get '/results' => sub {
    my $q = params->{q};
    my @results = vars->{db}->search_query( q => $q );
    template 'results', { results => \@results };
};

get '/browse' => sub {
    my @results = vars->{db}->get_all();
    template 'results', { results => \@results };
};

ajax '/ajax/add-line-to-order' => sub {
    set serializer => 'JSON';
    my $name = param('name');
    vars->{db}->add_line_to_order( $name );
    debug( "/ajax/add-line-to-order: $name" );
    # TODO : model orders linked to sessions
};

true;
