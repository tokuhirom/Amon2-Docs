#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use 5.010000;
use Fatal;
use File::Path qw/rmtree/;
use FindBin;

chdir $FindBin::Bin;

rmtree 'BBS';

eval "use Amon2::Plugin::DBI;1;" or system "cpanm", "Amon2::Plugin::DBI";

system "amon2-setup.pl BBS";
chdir 'BBS';

do_write('sql/sqlite3.sql', <<'...');
create table entry (
    entry_id INTEGER NOT NULL PRIMARY KEY,
    body varchar(255) not null
);
...

system "sqlite3 development.db < sql/sqlite3.sql";

do_write('lib/BBS.pm', <<'...');
package BBS;
use strict;
use warnings;
use parent qw/Amon2/;
our $VERSION='0.01';
use 5.008001;

use Amon2::Config::Simple;
sub load_config { Amon2::Config::Simple->load(shift) }

__PACKAGE__->load_plugin(qw/DBI/);

1;
...

do_write('lib/BBS/Web/Dispatcher.pm', <<'...');
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

no warnings 'redefine';
my $dbh = Amon2::DBI->connect('dbi:SQLite:', '', '', {});
$dbh->do(do { open my $fh, '<', 'sql/sqlite3.sql'; local $/; <$fh> });
sub BBS::dbh { $dbh }

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

system "perl Makefile.PL";
system "make test";

# ------------------------------------------------------------------------- 
# DSL

sub do_write {
    my ($fname, $src) = @_;
    open my $fh, ">:utf8", $fname;
    print {$fh} $src;
    close $fh;
}

