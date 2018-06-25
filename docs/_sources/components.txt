Components
==========

Amon2 is constructed  by the following modules.

Generic Context Object
----------------------

The Generic context object MUST inherit Amon2.pm.

You can use it as a context object on CLI.

The context object bootstrapping with following statement::

    package MyApp;
    use parent qw/Amon2/;

    package main;
    my $c = MyApp->bootstrap;

You can get a context object via ``$Amon2::CONTEXT`` from everywhere.

The Generic context object MUST implement the following abstract methods:

MyApp->load_config()
~~~~~~~~~~~~~~~~~~~~

This method returns configuration data. It MUST be a hashref.
Normally, this method using Amon2::Config::Simple.

Web Context Object
------------------

The Web context object SHOULD inherit Amon2::Web and the  Generic context object.

You can use it as follows::

    package MyApp::Web;
    use parent qw/MyApp Amon2::Web/;

    package main;
    my $app = MyApp::Web->to_app();

$app is a PSGI application. $app creates a  new instance of MyApp::Web per request and sends it to ``$Amon2::CONTEXT``.

The Web context object SHOULD have the following methods:

MyApp::Web->create_request($env)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Creates a new instance of Web request object.

MyApp::Web->create_response($code, $headers, $content)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Creates a new instance of Web response object.

MyApp::Web->create_view()
~~~~~~~~~~~~~~~~~~~~~~~~~

Creates a new instance of View object. It MUST support `Tiffany <http://search.cpan.org/perldoc?Tiffany>`_ protocol.

$c->dispatch()
~~~~~~~~~~~~~~

Dispatches the request to the real application.


Web request object
------------------

amon2-setup.pl creates MyApp::Web::Request. It inherits an Amon2::Web::Request and Plack::Request.

In theory, you can customize it. In practice, it is fequently left untouched.

Web response Object
--------------------

amon2-setup.pl creates MyApp::Web::Response. It inherits an Amon2::Web::Response and Plack::Response.

Normally, you don't need to touch it. But you can customize it.

