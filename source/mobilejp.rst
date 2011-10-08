Japanese Mobile Phones
======================

Japanese mobile phones have a very strange specs.

Detect phone informations from HTTP headers
-------------------------------------------

You can use HTTP::MobileAgent module to get a informantions from HTTP headers.

You would use Amon2::Plugin::Web::MobileAgent for this purpose. Install it from CPAN.::

    cpanm Amon2::Plugin::Web::MobileAgent

You can load a module.::

    package MyApp::Web;
    use parent qw/MyApp Amon2::Web/;
    __PACKAGE__->load_plugins('Web::MobileAgent');
    1;

and call it on your controller.::

    my $ma = $c->mobile_agent(); # instance of HTTP::MobileAgent

Change the Content-Type/encoding for mobile phones
--------------------------------------------------

I wrote a Amon2::Plugin::Web::MobileCharset.

Usage of this module is very easy. Install it from CPAN.::

    cpanm Amon2::Plugin::Web::MobileCharset

And load a plugin.::

    package MyApp::Web;
    use parent qw(Amon2::Web);

    __PACKAGE__->load_plugins(
        'Web::MobileAgent',
        'Web::MobileCharset',
    );

Amon2::Plugin::Web::MobileCharset provides $c->html_content_type method and $c->encoding method. You don't worry about charsets.

How can I convert a Japanese Zenkaku-Katakana to Hankaku-Katakana?
------------------------------------------------------------------

You can add a HTML filter. Install Lingua::JA::Regular::Unicode from CPAN.::

    cpanm Lingua::JA::Regular::Unicode

And you can add a katakana_z2h filter for HTML processing.::

    package MyApp::Web;
    use Lingua::JA::Regular::Unicode qw(katakana_z2h);
    __PACKAGE__->add_trigger(
        HTML_FILTER => sub {
            my ($c, $html) = @_;
            return katakana_z2h($html);
        }
    );

