Logging
=======

Log::Minimal
------------

I recommend `Log::Minimal <http://search.cpan.org/dist/Log-Minimal>`_ for logging with Amon2. It's very easy to use.

You can install it with following one liner::

    % curl -L cpanm | perl - Log::Minimal

And using it as::

    use Log::Minimal;

    infof("foo");  # info level
    warnf("foo");  # warn level
    debugf("ddd"); # debugging level

You can customize output format with `$Log::Minimal::PRINT`. And you can select log level with `$Log::Minimal::LOG_LEVEL`.

For more details, please access to `Log::Minimal <http://search.cpan.org/perldoc?Log::Minimal>`_ pod.

