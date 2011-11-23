use strict;
use warnings;
use utf8;
use Test::More;

use_ok $_ for qw(
    MyApp
    MyApp::Web
    MyApp::Web::Dispatcher
);

done_testing;
