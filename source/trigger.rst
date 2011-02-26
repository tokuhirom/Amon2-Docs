Triggers
========

Amon2 supports basic trigger feature like `Class::Trigger <http://search.cpan.org/perldoc?Class::Trigger>`_.

You can add the callback subroutine for following hook points.

BEFORE_DISPATCH
---------------

You can add the callback function by following code::

    package MyApp::Web;
    __PACKAGE__->add_trigger(
        BEFORE_DISPATCH => sub {
            my ($c) = @_;
            ...
        }
    );

If you returns object, is instance of Plack::Response, Amon2 does not calls dispatcher.

HTML_FILTER
-----------

This method called after rendering HTML. You can use it as following::

    package MyApp::Web;
    __PACKAGE__->add_trigger(
        HTML_FILTER => sub {
            my ($c, $html) = @_;
            ...
            return $html; # return rewrote html.
        }
    );

You can call it as a instance method. It's only works for this request. It's useful for operating HTML::

    sub dispatch {
        my $c = shift;
        ...
        $c->add_trigger(
            HTML_FILTER => sub {
                my ($c, $html) = @_;
                $html =~ s/John/Dan/;
                $html;
            }
        );
        ...
    }

AFTER_DISPATCH
--------------

This hook call after dispatch. You can use it as following::

    package MyApp::Web;
    __PACKAGE__->add_trigger(
        BEFORE_DISPATCH => sub {
            my ($c, $response) = @_;
            ...
        }
    );

This feature is useful to operate after rendering HTML, etc.

