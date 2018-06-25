Future plans
===================

I don't want to release Amon3 in 2011. But I have some ideas for Amon3.

Rename some modules
--------------------

I want rename the following modules::

    Amon2::Config::Simple => Amon3::Plugin::ConfigLoader

Change default configuration variable
-------------------------------------

Amon2 uses ``$ENV{PLACK_ENV}`` as the default configuration name.

Turns out that is a bad idea. It is hard to use. Amon2 should use ``$ENV{AMON2_ENV}`` or ``$ENV{"${PROJ}_ENV"}`` instead.

Context
-------

The current version of Amon2 uses $Amon2::CONTEXT as a global variable.
I want to make the global variable a project local variable.
