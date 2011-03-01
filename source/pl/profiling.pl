use strict;
use warnings;
use utf8;

use MyApp::Web;
use Devel::NYTprof;
use HTTP::Message::PSGI;
use HTTP::Request;
use HTTP::Response;

my $req = HTTP::Request->new('GET', 'http://localhost/');
my $env = $req->to_psgi();

my $app = MyApp::Web->to_app();
print res_from_psgi($app->($env))->as_string;

my $n = shift || 1000;
for (1..$n) {
    $app->($env);
}

