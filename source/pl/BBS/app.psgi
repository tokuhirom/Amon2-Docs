use strict;
use utf8;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'extlib', 'lib', 'perl5');
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use Plack::Builder;

use BBS::Web;
use BBS;
use Plack::Session::Store::File;
use Plack::Session::State::Cookie;
use URI::Escape;
use File::Path ();

my $session_dir = File::Spec->catdir(File::Spec->tmpdir, uri_escape("BBS") . "-$<" );
File::Path::mkpath($session_dir);
builder {
    enable 'Plack::Middleware::Static',
        path => qr{^(?:/static/)},
        root => File::Spec->catdir(dirname(__FILE__));
    enable 'Plack::Middleware::Static',
        path => qr{^(?:/robots\.txt|/favicon\.ico)$},
        root => File::Spec->catdir(dirname(__FILE__), 'static');
    enable 'Plack::Middleware::ReverseProxy';

    # If you want to run the app on multiple servers,
    # you need to use Plack::Sesion::Store::DBI or ::Store::Cache.
    enable 'Plack::Middleware::Session',
        store => Plack::Session::Store::File->new(
            dir => $session_dir,
        ),
        state => Plack::Session::State::Cookie->new(
            httponly => 1,
        );
    BBS::Web->to_app();
};
