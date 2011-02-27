Database Integration
====================

DBI
---

Amon2 provides ``Amon2::DBI`` with splitted package `Amon2-DBI <http://search.cpan.org/dist/Amon2-DBI/>`_.

``Amon2::Web`` provides following features on DBI:

    * Better error message
    * RAII style transaction management(DBIx::TransactionManager)
    * SQL construction helper(with SQL::Interp)

You can install it by following one liner::

    % curl -L http://cpanmin.us | perl - Amon2::DBI

And it contains ``Amon2::Plugin::DBI``. You can use the plugin as::

    package MyApp;
    __PACKAGE__->load_plugin(qw/DBI/);

Then you can access the instance of DBI, you can call ``$c->dbh``.

Transaction management
~~~~~~~~~~~~~~~~~~~~~~

You can use it as following::

    my $dbh = Amon2::DBI->connect(...);
    my $txn = $dbh->txn_scope();
    ...
    $txn->commit();

You can handle nested transaction.

For more details please access `DBIx::TransactionManager <http://search.cpan.org/perldoc?DBIx::TransactionManager>`_.

SQL helper
~~~~~~~~~~

For your convenience, ``Amon2::DBI`` provides following helper methods.

$dbh->do_i(@args)
``````````````````

This method construct SQL using ``SQL::Interp::sql_interp`` and do it.

$dbh->insert($table, \%row);
````````````````````````````

This is equivalent to::

    $dbh->do_i(qq{INSERT INTO $table }, \%row);

Teng
----

Amon2 does not support O/R Mapper especially.
But you can integrate every O/R mappers very easy!

This article provides tutorial for using `Teng <http://search.cpan.org/perldoc?Teng>`_ with Amon2.

And write constructor for context object::

    package MyApp;
    use parent qw/Amon2/;
    use Teng::Schema::Loader;
    use Teng;

    sub db {
        my $self = shift;
        if ( !defined $self->{db} ) {
            my $conf = $self->config->{'DB'}
              or die "missing configuration for 'DB'";
            my $dbh = DBI->connect($conf);
            my $schema = Teng::Schema::Loader->load(
                namespace => 'MyApp::DB',
                dbh       => $dbh,
            );
            $self->{db} = Teng->new(
                dbh    => $dbh,
                schema => $schema,
            );
        }
        return $self->{db};
    }

    1;

