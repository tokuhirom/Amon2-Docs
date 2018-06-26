Outputting data other than HTML
===============================

JSON
----

Amon2::Plugin::Web::JSON supports output in JSON format. You can load it as::

    __PACKAGE__->load_plugin(qw/JSON/);

And use it as follows::

    sub dispatch {
        my $c = shift;

        my $response = $c->render_json({'data' => 'OK'});
        return $response;
    }

If you want to use JSONP, you would use `Plack::Middleware::JSONP <http://search.cpan.org/perldoc?Plack::Middleware::JSONP>`_.

CSV
---

Amon2 does not support CSV, but you can output CSV data using `Text::CSV <http://search.cpan.org/perldoc?Text::CSV>`_::

    sub dispatch {
        my $c = shift;

        my $csv = Text::CSV->new ( { binary => 1 } )
            or die "Cannot use CSV: ".Text::CSV->error_diag ();

        my $output = join("\n",
            $csv->combine(qw/Foo Bar Baz/),
            $csv->combine(qw/1 2 3/),
        );

        return $c->create_response(
            200,
            [
                'Content-Disposition' => 'attachment; filename=somefilename.csv',
                'Content-Type' => 'text/csv; charset=utf-8',
            ],
            [$output]
        );
    }


