CLI(Command Line Interface)
===========================

Most web applications have command line scripts. Amon2 supports this feature.

You can use the context object on CLI::

    #!/usr/bin/env perl
    use strict;
    use warnings;
    use utf8;
    use MyApp;

    my $c = MyApp->bootstrap();

``$c`` is a instance of MyApp. You can access to it via ``$Amon2::CONTEXT``.

When you write some methods on context object, you should think in the following way: "Is this a web-context only feature? Or not ?". If your feature is not only web specific, you write it on MyApp.pm module, so you can use it under the CLI.

This technique goes beyond CLI. You can apply it for job queue workers, AnyEvent daemons, etc, etc.

