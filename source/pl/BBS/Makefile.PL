use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'BBS',
    AUTHOR        => 'Some Person <person@example.com>',
    VERSION_FROM  => 'lib/BBS.pm',
    PREREQ_PM     => {
        'Amon2'                           => '2.54',
        'Text::Xslate'                    => '1.4001',
        'Text::Xslate::Bridge::TT2Like'   => '0.00008',
        'Plack::Middleware::ReverseProxy' => '0.09',
        'Time::Piece'                     => '1.20',
        'Amon2::DBI'                      => '0',
        'HTTP::Session'                   => '0.44',
        'JSON'                            => '2',
        'HTML::FillInForm::Lite'          => '1.09',
    },
    MIN_PERL_VERSION => '5.008001',
    (-d 'xt' and $ENV{AUTOMATED_TESTING} || $ENV{RELEASE_TESTING}) ? (
        test => {
            TESTS => 't/*.t xt/*.t',
        },
    ) : (),
);

