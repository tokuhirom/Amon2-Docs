package t::Util;
BEGIN {
    unless ($ENV{PLACK_ENV}) {
        $ENV{PLACK_ENV} = 'test';
    }
}
use parent qw/Exporter/;
use Test::More 0.96;

{
    # utf8 hack.
    binmode Test::More->builder->$_, ":utf8" for qw/output failure_output todo_output/;                       
    no warnings 'redefine';
    my $code = \&Test::Builder::child;
    *Test::Builder::child = sub {
        my $builder = $code->(@_);
        binmode $builder->output,         ":utf8";
        binmode $builder->failure_output, ":utf8";
        binmode $builder->todo_output,    ":utf8";
        return $builder;
    };
}

# setup database
use BBS;
open my $fh, "<", "sql/sqlite3.sql" or die "Cannot open file: sql/sqlite3.sql";
unlink 'test.db' if -f 'test.db';
my $c = BBS->new;
for (grep /\S/, split /;/, do { local $/; <$fh> }) {
    $c->dbh->do($_);
}

1;
