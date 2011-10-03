Plugin
======

Plugin architecture
-------------------

Amon2's plugin architecture is very simple.

Plugin class MUST implement ``MyPlugin->init($context_class, \%configuration)``. That's all.

``$context_class`` is a class name. It would be child class of the ``Amon2``.

Flavor
------

Amon2.60+ provides setup script for plugins.

Plugins can inject a code for bootstrapping code by::

    % amon2-setup.pl --plugin=Teng MyApp

Just add a "@@" lines based on __DATA__ section::

    package Amon2::Plugin::Web::PlackSession;
    __DATA__

    @@ prereq_pm
        'Plack::Middleware::Session' => 0,
    @@ web_context
    use Plack::Session;
    sub session {
        $_[0]->{session} //= Plack::Session->new($_[0]->req->env);
    }
    @@ middleware
    enable 'Plack::Middleware::Session';

Hook points
~~~~~~~~~~~

Makefile.PL
^^^^^^^^^^^

add a prerequired modules for Makefile.PL.

app.psgi
^^^^^^^^

app.psgi

<<CONTEXT_PATH>>
^^^^^^^^^^^^^^^^^

Add a snippet for lib/MyApp.pm.

<<WEB_CONTEXT_PATH>>
^^^^^^^^^^^^^^^^^^^^^

Add a snippet for lib/MyApp/Web.pm.


