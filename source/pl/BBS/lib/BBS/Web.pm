package BBS::Web;
use strict;
use warnings;
use parent qw/BBS Amon2::Web/;
use File::Spec;

# load all controller classes
use Module::Find ();
Module::Find::useall("BBS::Web::C");

# dispatcher
use BBS::Web::Dispatcher;
sub dispatch {
    return BBS::Web::Dispatcher->dispatch($_[0]) or die "response is not generated";
}

# setup view class
use Text::Xslate;
use File::Spec;
{
    my $view_conf = __PACKAGE__->config->{'Text::Xslate'} || +{ };
    unless (exists $view_conf->{path}) {
        $view_conf->{path} = [ File::Spec->catdir(__PACKAGE__->base_dir(), 'tmpl') ];
    }
    my $view = Text::Xslate->new(+{
        'syntax'   => 'TTerse',
        'module'   => [ 'Text::Xslate::Bridge::TT2Like' ],
        'function' => {
            c        => sub { Amon2->context() },
            uri_with => sub { Amon2->context()->req->uri_with(@_) },
            uri_for  => sub { Amon2->context()->uri_for(@_) },
            static_file => do {
                my %static_file_cache;
                sub {
                    my $fname = shift;
                    my $c = Amon2->context;
                    if (not exists $static_file_cache{$fname}) {
                        my $fullpath = File::Spec->catfile($c->base_dir(), $fname);
                        $static_file_cache{$fname} = (stat $fullpath)[9];
                    }
                    return $c->uri_for($fname, { 't' => $static_file_cache{$fname} });
                }
            },
        },
        %$view_conf
    });
    sub create_view { $view }
}


use HTTP::Session::Store::File;
__PACKAGE__->load_plugins(
    'Web::HTTPSession' => {
        state => 'Cookie',
        store => HTTP::Session::Store::File->new(
            dir => File::Spec->tmpdir(),
        )
    },
);

__PACKAGE__->load_plugin(qw/Web::JSON/);

__PACKAGE__->load_plugin(qw/Web::CSRFDefender/);

__PACKAGE__->load_plugin(qw/Web::FillInFormLite/);

__PACKAGE__->load_plugin(qw/Web::NoCache/);


# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;
        $res->header( 'X-Content-Type-Options' => 'nosniff' );
    },
);
__PACKAGE__->add_trigger(
    BEFORE_DISPATCH => sub {
        my ( $c ) = @_;
        # ...
        return;
    },
);

1;

