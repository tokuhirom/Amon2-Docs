Future plans
===================

I don't want to release Amon3 in 2011. But I have some ideas for Amon3.

Rename some modules
--------------------

I want rename following modules::

    Amon2::Config::Simple => Amon3::Plugin::ConfigLoader

Change default configuration variable
-------------------------------------

Amon2 uses ``$ENV{PLACK_ENV}`` as default configuration name.

But it's bad idea. It makes hard to use. Amon2 should use ``$ENV{AMON2_ENV}`` or ``$ENV{"${PROJ}_ENV"}`` instead.

Context
-------

Current version of Amon2 uses $Amon2::CONTEXT as a global variable.
I want to make it as project local variable.
