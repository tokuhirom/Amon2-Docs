use strict;
use warnings;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;
use lib 'lib';
use BBS;

my $app = Plack::Util::load_psgi 'BBS.psgi';

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
