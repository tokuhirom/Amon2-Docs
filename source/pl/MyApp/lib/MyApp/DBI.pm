use strict;
use warnings;

package MyApp::DBI;
use parent qw/DBI/;

sub connect {
	my ($self, $dsn, $user, $pass, $attr) = @_;
    $attr->{RaiseError} = 0;
    if ($DBI::VERSION >= 1.614) {
        $attr->{AutoInactiveDestroy} = 1 unless exists $attr->{AutoInactiveDestroy};
    }
	if ($dsn =~ /^dbi:SQLite:/) {
		$attr->{sqlite_unicode} = 1 unless exists $attr->{sqlite_unicode};
	}
    if ($dsn =~ /^dbi:mysql:/) {
        $attr->{mysql_enable_utf8} = 1 unless exists $attr->{mysql_enable_utf8};
    }
	return $self->SUPER::connect($dsn, $user, $pass, $attr) or die "Cannot connect to server: $DBI::errstr";
}

package MyApp::DBI::dr;
our @ISA = qw(DBI::dr);

package MyApp::DBI::db;
our @ISA = qw(DBI::db);

use DBIx::TransactionManager;
use SQL::Interp ();

sub _txn_manager {
    my $self = shift;
    $self->{private_txn_manager} //= DBIx::TransactionManager->new($self);
}

sub txn_scope { $_[0]->_txn_manager->txn_scope(caller => [caller(0)]) }

sub do_i {
    my $self = shift;
    my ($sql, @bind) = SQL::Interp::sql_interp(@_);
    $self->do($sql, {}, @bind);
}

sub insert {
    my ($self, $table, $vars) = @_;
    $self->do_i("INSERT INTO $table", $vars);
}

sub prepare {
    my ($self, @args) = @_;
    my $sth = $self->SUPER::prepare(@args) or do {
        MyApp::DBI::Util::handle_error($_[1], [], $self->errstr);
    };
    $sth->{private_sql} = $_[1];
    return $sth;
}

package MyApp::DBI::st;
our @ISA = qw(DBI::st);

sub execute {
    my ($self, @args) = @_;
    $self->SUPER::execute(@args) or do {
        MyApp::DBI::Util::handle_error($self->{private_sql}, \@args, $self->errstr);
    };
}

sub sql { $_[0]->{private_sql} }

package MyApp::DBI::Util;
use Carp::Clan qw{^(DBI::|MyApp::DBI::|DBD::)};
use Data::Dumper ();

sub handle_error {
    my ( $stmt, $bind, $reason ) = @_;

    $stmt =~ s/\n/\n          /gm;
    my $err = sprintf <<"TRACE", $reason, $stmt, Data::Dumper::Dumper($bind);

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@ MyApp::DBI 's Exception @@@@@
Reason  : %s
SQL     : %s
BIND    : %s
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
TRACE
    $err =~ s/\n\Z//;
    croak $err;
}

