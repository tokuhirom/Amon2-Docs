WebSocket support
=================

Amon2 supports WebSocket natively(experimental).

INSTALLATION
------------

Amon2's websocket support is bundleed on core distribution, but there's missing deps.

    % cpanm Protocol::WebSocket Twiggy

Amon2 using Protocol::WebSocket as a protocol parser, and Twiggy is a httpd. You can't use Starlet/Starman to support WebSocket.

CODE
----

It's very easy to use.

    any '/echo' => sub {
        my ($c) = @_;
        return $c->websocket(sub {
            my $ws = shift;
            $ws->on_receive_message(sub {
                my ($c, $message) = @_;
                $ws->send_message("YAY: " . $message);
            });
        });
    };

And full code of chat application is here: http://api.metacpan.org/source/TOKUHIROM/Amon2-3.52/eg/realtime-chat/chat.psgi

SEE ALSO
--------

https://metacpan.org/module/Amon2::Plugin::Web::WebSocket
