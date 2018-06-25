Template Engine
===============

Amon2 ♥ Xslate
---------------

Amon2 uses `Text::Xslate <http://xslate.org/>`_ as a default template engine.

How do I use alternative template engine.
-----------------------------------------

I am highly recommend Text::Xslate, but you can use any template engine supported by `Tiffany <http://search.cpan.org/perldoc?Tiffany>`_. It wraps difference of every template engines.::

    package MyApp::Web;
    use parent qw/MyApp Amon2::Web/;
    use Tiffany;

    my $tmpl = Tiffany->load('Text::MicroTemplate::File');
    sub create_view { $tmpl }

Normally, you should cache the instance of template engine object.

