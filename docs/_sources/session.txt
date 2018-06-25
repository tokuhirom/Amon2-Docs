Session
=======

Plack::Session
--------------

Amon2 uses `Plack::Session <http://search.cpan.org/dist/Plack-Session/>`_ for session management.

You can use it by zero configuraion::

    sub dispatch {
        my $c = shift;
        my $cnt = $c->session->get('cnt') || 0;
        $c->session->set('cnt' => ++$cnt);
        return $c->create_response(200, ['Content-Type' => 'text/plain'], [$cnt]);
    }

HTTP::Session
-------------

You can use `HTTP::Session <http://search.cpan.org/dist/HTTP-Session>`_ too.

Example usage is here::

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

