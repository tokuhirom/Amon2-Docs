package BBS::Web::Dispatcher;
use strict;
use warnings;

use Amon2::Web::Dispatcher::Lite;

any '/' => sub {
    my ($c) = @_;

    my @entries = @{$c->dbh->selectall_arrayref(
        q{SELECT * FROM entry ORDER BY entry_id DESC LIMIT 10},
        {Slice => {}}
    )};
    return $c->render( "index.tt" => { entries => \@entries, } );
};

post '/post' => sub {
    my ($c) = @_;

    if (my $body = $c->req->param('body')) {
        $c->dbh->insert(entry => +{
            body => $body,
        });
    }
    return $c->redirect('/');
};

1;
