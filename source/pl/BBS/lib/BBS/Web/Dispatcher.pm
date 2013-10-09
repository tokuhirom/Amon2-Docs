package BBS::Web::Dispatcher;
use strict;
use warnings;

use Amon2::Web::Dispatcher::Lite;

any '/' => sub {
    my ($c) = @_;

    my @entries = $c->db->search(
        entry => {
        }, {
            order_by => 'entry_id DESC',
            limit    => 10,
        }
    );
    return $c->render( "index.tx" => { entries => \@entries, } );
};

post '/post' => sub {
    my ($c) = @_;

    if (my $body = $c->req->param('body')) {
        $c->db->insert(
            entry => +{
                body => $body,
            }
        );
    }
    return $c->redirect('/');
};

1;
