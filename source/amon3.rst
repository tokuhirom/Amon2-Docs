Prospects for Amon3
===================

I don't want to release Amon3 in 2011. But I have some ideas for Amon3.

Switch to Plack::Session
------------------------

Main reason to select HTTP::Session in Amon2 is Japanese mobile phones support.
So, Plack::Session does not supports Plack::Session::State::URI. And timing of I started Amon2 development, Plack::Session is not stable yet(I think). But today, Plack::Session is stable enough. And DoCoMo phones support Cookie today. When I start Amon3 project, I don't need to support cookie unavailable phones(I hope).

Rename some modules
--------------------

I want rename following modules::

    Amon2::Config::Simple => Amon3::ConfigLoader

Change default configuration variable
-------------------------------------

Amon2 uses ``$ENV{PLACK_ENV}`` as default configuration name.

But it's bad idea. It makes hard to use. Amon3 should use ``$ENV{AMON3_ENV}`` or ``$ENV{"${PROJ}_ENV"}`` instead.

