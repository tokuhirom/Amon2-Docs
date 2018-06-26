Request/Response
================

How do you extend request/response class?
-----------------------------------------

You can use your own request/response class. You can write it as::

    package MyApp::Web::Request;
    use parent qw/Amon2::Web::Request/;

    package MyApp::Web::Response;
    use parent qw/Amon2::Web::Response/;

And use it by web context::

    package MyApp::Web;
    use parent qw/MyApp Amon2/;

    use MyApp::Web::Request;
    use MyApp::Web::Response;
    sub create_request { MyApp::Web::Request->new($_[1]) }
    sub create_response { shift; MyApp::Web::Response->new(@_) }

