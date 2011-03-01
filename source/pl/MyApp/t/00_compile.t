use strict;
use warnings;
use Test::More;

use_ok $_ for qw(
    MyApp
    MyApp::DBI
    MyApp::Web
    MyApp::Web::Dispatcher
);

done_testing;
