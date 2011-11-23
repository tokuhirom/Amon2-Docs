use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'MyApp',
    AUTHOR        => 'Some Person <person@example.com>',
    VERSION_FROM  => 'lib/MyApp.pm',
    PREREQ_PM     => {
        'Amon2'                           => '3.25',
        'Text::Xslate'                    => '1.5006',
        'Test::More'                      => '0.98',
        'Amon2::DBI'                      => '0.06',
        'DBD::SQLite'                     => '1.33',
        'HTML::FillInForm::Lite'          => '1.09',
        'JSON'                            => '2.50',
        'Log::Minimal'                    => '0.06',
        'Plack::Middleware::ReverseProxy' => '0.09',
        'Plack::Middleware::Session'      => '0',
        'Plack::Session'                  => '0.14',
        'String::CamelCase'               => '0.02',
        'Test::WWW::Mechanize::PSGI'      => '0',
        'Time::Piece'                     => '1.20',
    },
    MIN_PERL_VERSION => '5.008001',
    (-d 'xt' and $ENV{AUTOMATED_TESTING} || $ENV{RELEASE_TESTING}) ? (
        test => {
            TESTS => 't/*.t xt/*.t',
        },
    ) : (),
);
