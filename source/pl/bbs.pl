#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use 5.010000;
use autodie ":all";
use File::Path qw/rmtree/;
use FindBin;

chdir $FindBin::Bin;

rmtree 'BBS';

system "amon2-setup.pl BBS";
chdir 'BBS';
system "cpanm --installdeps .";

do_write('sql/sqlite.sql', slurp('sql/sqlite.sql') . "\n" . <<'...');
CREATE TABLE IF NOT EXISTS sessions (
    id           CHAR(72) PRIMARY KEY,
    session_data TEXT
);

CREATE TABLE IF NOT EXISTS entry (
    entry_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    body varchar(255) not null
);
...

system "sqlite3 db/development.db < sql/sqlite.sql";
system "sqlite3 db/test.db < sql/sqlite.sql";

do_write('lib/BBS/DB/Schema.pm', <<'...');
package BBS::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'BBS::DB::Row';

table {
    name 'sessions';
    pk 'id';
    columns qw(session_data);
};

table {
    name 'entry';
    pk 'entry_id';
    columns qw(entry_id body);
};

1;
...

do_write('lib/BBS/Web/Dispatcher.pm', <<'...');
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
    return $c->render( "index.tt" => { entries => \@entries, } );
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
...

do_write('tmpl/index.tt', <<'...');
[% WRAPPER 'include/layout.tt' %]

<form method="post" action="[% uri_for('/post') %]">
    <input type="text" name="body" />
    <input type="submit" value="Send" />
</form>

<ul>
[% FOR entry IN entries %]
    <li>[% entry.entry_id %]. [% entry.body %]</li>
[% END %]
</ul>

[% END %]
...

do_write('t/01_root.t', <<'...');
use strict;
use warnings;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;
use lib 'lib';
use BBS;

my $app = Plack::Util::load_psgi 'app.psgi';

test_psgi
    app => $app,
    client => sub {
        my $cb = shift;
        my $req = HTTP::Request->new(GET => 'http://localhost/');
        my $res = $cb->($req);
        is $res->code, 200;
        diag $res->content if $res->code != 200;
    };

done_testing;
...

unlink 't/02_mech.t';

system "prove -lr t";

# ------------------------------------------------------------------------- 
# DSL

sub slurp {
    my $fname = shift;
    open my $fh, '<:utf8', $fname or die "$fname: $!";
    local $/;
    <$fh>;
}

sub do_write {
    my ($fname, $src) = @_;
    open my $fh, ">:utf8", $fname or die "Cannot open file $fname: $!";
    print {$fh} $src;
    close $fh;
}

