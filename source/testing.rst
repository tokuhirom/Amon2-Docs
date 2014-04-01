Testing
=======

Basic Unit testing
------------------

You can use ``perl Build.PL; ./Build; ./Build test`` flow,same as normal perl project. If you don't know about Perl5 testing, please read `Test::Tutorial <http://search.cpan.org/perldoc?Test::Tutorial>`_.

Test::WWW::Mechanize::PSGI
--------------------------

Test::WWW::Mechanize::PSGI is a very useful module for testing PSGI applications like Amon2 web application. I recommend this module for testing Amon2 application.

You can write basic test like following::

    use Test::WWW::Mechanize::PSGI
    use MyApp::Web;
    
    my $app = MyApp::Web->to_app();
    my $mech = Test::WWW::Mechanize::PSGI->new(app => $app);
    $mech->get_ok('http://localhost/'); # testing top page is OK

Checking broken links
~~~~~~~~~~~~~~~~~~~~~

You can check broken link with ``$mech->page_links_ok()``.

How do I mocking time?
----------------------

You can use `Time::Mock <http://search.cpan.org/perldoc?Time::Mock>`_.

This module replaces core functions of Perl5.

For more details, please access to Test::Mock pod on CPAN.

