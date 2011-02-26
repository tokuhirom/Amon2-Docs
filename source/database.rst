Database Integration
====================

DBI
---

amon2-setup.pl creates ``MyApp::DBI``.

``MyApp::Web`` provides following features on DBI:

    * Better error message
    * RAII style transaction management(DBIx::TransactionManager)
    * SQL construction helper(with SQL::Interp)

Transaction management
~~~~~~~~~~~~~~~~~~~~~~

You can use it as following::

    my $dbh = MyApp::DBI->connect(...);
    my $txn = $dbh->txn_scope();
    ...
    $txn->commit();

You can handle nested transaction.

For more details please access `DBIx::TransactionManager <http://search.cpan.org/perldoc?DBIx::TransactionManager>`_.

SQL helper
~~~~~~~~~~

For your convenience, ``MyApp::DBI`` provides following helper methods.

$dbh->do_i(@args)
``````````````````

This method construct SQL using ``SQL::Interp::sql_interp`` and do it.

$dbh->insert($table, \%row);
````````````````````````````

This is equivalent to::

    $dbh->do_i(qq{INSERT INTO $table }, \%row);

Teng
----

You can use `Teng <http://search.cpan.org/perldoc?Teng>`_ as a O/R Mapper.

You write ``lib/MyApp/DB.pm`` as following::

    package MyApp::DB;
    use parent qw/Teng/;
    1;

And write constructor for context object::

    package MyApp;
    use parent qw/Amon2/;
    use MyApp::DB;

    sub db {
        my $self = shift;
        if ( !defined $self->{dbh} ) {
            my $conf = $self->config->{'DB'}
              or die "missing configuration for 'DB'";
            $self->{dbh} = MyApp::DBI->connect($conf);
        }
        return $self->{dbh};
    }
    1;

