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

Web Context Object
------------------

Web context object SHOULD inherit Amon2::Web and Generic context object.

You can use it as following::

    package MyApp::Web;
    use parent qw/MyApp Amon2::Web/;

    package main;
    my $app = MyApp::Web->to_app();

$app is a PSGI application.

Web Request Object
------------------

amon2-setup.pl creates MyApp::Web::Request. It inherit a Amon2::Web::Request and Plack::Request.

Normally, you don't need to touch it. But you can customize it.

Web Response Object
--------------------

amon2-setup.pl creates MyApp::Web::Response. It inherit a Amon2::Web::Response and Plack::Response.

Normally, you don't need to touch it. But you can customize it.

