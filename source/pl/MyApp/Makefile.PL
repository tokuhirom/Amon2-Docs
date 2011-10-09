use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'MyApp',
    AUTHOR        => 'Some Person <person@example.com>',
    VERSION_FROM  => 'lib/MyApp.pm',
    PREREQ_PM     => {
        'Amon2'                           => '2.56',
        'Text::Xslate'                    => '1.4001',
        'Text::Xslate::Bridge::TT2Like'   => '0.00008',
        'Plack::Middleware::ReverseProxy' => '0.09',
        'HTML::FillInForm::Lite'          => '1.09',
        'Time::Piece'                     => '1.20',
		'Test::More'                      => '0.98',
        'DBD::SQLite'                         => '1.33',
        'Plack::Session'                         => '0.14',
        'Amon2::DBI'                         => '0.05',
    },
    MIN_PERL_VERSION => '5.008001',
    (-d 'xt' and $ENV{AUTOMATED_TESTING} || $ENV{RELEASE_TESTING}) ? (
        test => {
            TESTS => 't/*.t xt/*.t',
        },
    ) : (),
);
