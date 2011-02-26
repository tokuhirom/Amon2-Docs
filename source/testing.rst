Testing
=======

Basic Unit testing
------------------

You can use ``perl Makefile.PL; make; make test`` flow,same as normal perl project. If you don't know about Perl5 testing, please read `Test::Tutorial <http://search.cpan.org/perldoc?Test::Tutorial>`_.

Test::WWW::Mechanize::PSGI
--------------------------

Test::WWW::Mechanize::PSGI is a very useful module for testing PSGI applications like Amon2 web application. I recommend this module for testing Amon2 application.

You can write basic test like following::

    use Test::WWW::Mechanize::PSGI
    use MyApp::Web;
    
    my $app = MyApp::Web->to_app();
    my $mech = Test::WWW::Mechanize::PSGI->new(app => $app);
    $mech->get_ok('http://localhost/'); # testing top page is OK

