Session
=======

HTTP::Session
-------------

Amon2 uses `HTTP::Session <http://search.cpan.org/dist/HTTP-Session/>`_ for session management by Amon2::Plugin::Web::HTTPSession.

The plug-in is enabled by default. You can see the configuration in skeleton file created by amon2-setup.pl::

    package MyApp::Web;
    use parent qw/MyApp Amon2/;

    use HTTP::Session::Store::File;

    __PACKAGE__->load_plugins(
        'Web::HTTPSession' => {
            state => 'Cookie',
            store => HTTP::Session::Store::File->new(
                dir => File::Spec->tmpdir(),
            )
        },
    );

And you can access instance of HTTP::Session by calling ``$c->session``. Here is a very simple counter using session::

    package MyApp::Web::Dispatcher;

    get '/' => sub {
        my $c = shift;
        my $cnt = $c->session->get('cnt') || 0;
        $c->session->set('cnt' => ++$cnt);
        return $c->create_response(200, ['Content-Type' => 'text/plain'], [$cnt]);
    };

For more details, please look `HTTP::Session <http://search.cpan.org/dist/HTTP-Session/>`_ and `Amon2::Plugin::Web::HTTPSession <http://search.cpan.org/perldoc?Amon2::Plugin::Web::HTTPSession>`_.

Plack::Session
--------------

You can use `Plack::Session <http://search.cpan.org/dist/Plack-Session>`_ too.

You write a bootstrap code for Plack::Middleware::Session::

    builder {
        enable 'Session';

        MyApp::Web->to_app();
    };

And enable Amon2::Plugin::Web::PlackSession::

    package MyApp::Web;
    __PACKAGE__->load_plugin(qw/Web::PlackSession/);

And use it::

    sub dispatch {
        my $c = shift;
        my $cnt = $c->session->get('cnt') || 0;
        $c->session->set('cnt' => ++$cnt);
        return $c->create_response(200, ['Content-Type' => 'text/plain'], [$cnt]);
    }

