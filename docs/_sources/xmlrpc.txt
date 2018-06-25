XMLRPC
======

How do you implement XMLRPC server with Amon2?
----------------------------------------------

Amon2 does not support XMLRPC server. But you can implement it as PSGI application and run with Amon2 context object::

    use strict;
    use warnings;
    use Plack::Request;
    use Plack::Builder;
    use RPC::XML;
    use RPC::XML::ParserFactory 'XML::LibXML';

    sub res { RPC::XML::response->new(@_) }

    my %dispatch_table = (
        'sum' => sub {
            my $args = shift->value;
            return res(0 + $args->{a} + $args->{b});
        },
        'echo' => sub {
            my $args = shift->value;
            return res($args);
        },
    );

    my $app = sub {
        my $req = Plack::Request->new(@_);
        my $q = RPC::XML::ParserFactory->new()->parse($req->content);
        my $method_name = $q->name;
        my $code = $dispatch_table{$method_name} or return [404, [], ["not found: $method_name"]];
        my $rpc_res = $code->(@{$q->args});
        return [ 200, [ 'Content-Type', 'text/xml' ], [ $rpc_res->as_string ] ];
    };
    builder {
        enable 'ContentLength';
        $app;
    };

You can create the context object by ``MyApp->bootstrap()``, same as CLI.

