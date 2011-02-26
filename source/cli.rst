CLI(Command Line Interface)
===========================

Most of the web application have a command line scripts. Amon2 supports it.

You can use the context object on CLI::

    #!/usr/bin/env perl
    use strict;
    use warnings;
    use utf8;
    use MyApp;

    my $c = MyApp->bootstrap();

``$c`` is a instance of MyApp. And you can access it by ``$Amon2::CONTEXT``.

When you write some methods on context object, you should think "Is this web context only thing? or not ?". If the thing is not only web specific, you write it on MyApp.pm, then you can use it under the CLI.

You can use this technique on other than CLI, like job queue worker, AnyEvent daemon, etc, etc.

