Components
==========

Amon2 is constructed by following modules.

Generic Context Object
----------------------

Generic context object MUST inherit Amon2.pm.

You can use it as context object on CLI.

The context object bootstrapping with following statement::

    package MyApp;
    use parent qw/Amon2/;

    package main;
    my $c = MyApp->bootstrap;

You can get a context object by ``$Amon2::CONTEXT`` from everywhere.

Generic context object MUST implement following abstract methods::

MyApp->load_config()
~~~~~~~~~~~~~~~~~~~~

This method returns configuration data. It MUST be hashref.
Normally, this method using Amon2::Config::Simple.

Web Context Object
------------------

Web context object SHOULD inherit Amon2::Web and Generic context object.

You can use it as following::

    package MyApp::Web;
    use parent qw/MyApp Amon2::Web/;

    package main;
    my $app = MyApp::Web->to_app();

$app is a PSGI application. $app create new instance of MyApp::Web per request and set it to ``$Amon2::CONTEXT``.

Web context object SHOULD have following methods.

MyApp::Web->create_request($env)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a new instance of Web request object.

MyApp::Web->create_response($code, $headers, $content)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a new instance of Web response object.

MyApp::Web->create_view()
~~~~~~~~~~~~~~~~~~~~~~~~~

Create a new instance of view object. It MUST support `Tiffany <http://search.cpan.org/perldoc?Tiffany>`_ protocol.

$c->dispatch()
~~~~~~~~~~~~~~

Dispatch the request to real application.


Web request object
------------------

amon2-setup.pl creates MyApp::Web::Request. It inherit a Amon2::Web::Request and Plack::Request.

Normally, you don't need to touch it. But you can customize it.

Web response Object
--------------------

amon2-setup.pl creates MyApp::Web::Response. It inherit a Amon2::Web::Response and Plack::Response.

Normally, you don't need to touch it. But you can customize it.

