Configuration
=============

Amon2 uses .pl file as configuration file. It provides full of flexibility.

amon2-setup.pl makes following code by default::

    package MyApp;
    use parent qw/Amon2/;
    use Amon2::Config::Simple;
    sub load_config { Amon2::Config::Simple->load(shift) }

``MyApp->load_config()`` is a class method to load configuration data.

``Amon2::Config::Simple`` reads a ``"config/$ENV{PLACK_ENV}.pl"`` by default. If the ``$ENV{PLACK_ENV}`` is null, Amon2 uses ``"config/$ENV{PLACK_ENV}.pl"`` instead.

If you want more flexibility, you can write your own configuration loader without ``Amon2::Config::Simple`` (e.g. Load configuration data from YAML, etc.).

