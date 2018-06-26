E-mail
======

Amon2 does not support any E-mail related feature specifically. But you can send e-mail using CPAN modules!

Sending E-mail with Email::Sender
---------------------------------

You can send e-mail very easy!::

    use Email::MIME;
    use Email::Sender::Simple;

    my $message = Email::MIME−>create(
            header => [
                From => 'my@address',
                To   => 'your@address',
            ],
            parts => [
                q[This is part one],
                q[This is part two],
                q[These could be binary too],
            ],
        );

    Email::Sender::Simple->send( $message );

If you don't want to depend on  Moose for bootstrap time or memory saving, you can try  Email::Send instead.

Receiving E-mail
----------------

Well, this is not a topic for Amon2.

Please read `Email::MIME <http://search.cpan.org/perldoc?Email::MIME>`_ docs.

