Tutorial - Create BBS site
===========================

Create skeleton
---------------

Just type::

    % amon2-setup.pl BBS
    % cd BBS/
    % curl -L http://cpanmin.us | perl - --installdeps .

Setup database
---------------

Put sql/sqlite.sql.

.. literalinclude:: pl/BBS/sql/sqlite.sql

You can find the configuration about RDBMS is config/development.pl

.. literalinclude:: pl/BBS/config/development.pl

Run the web server
------------------

You can run the testing web server with following command::

    % plackup app.psgi
    HTTP::Server::PSGI: Accepting connections at http://0:5000/

Then, you can access the http://0.5000/ for testing.

Load plugins
------------

This application requires Amon2::Plugin::DBI. You would load it.

.. literalinclude:: pl/BBS/lib/BBS.pm

Implement controller
--------------------

Open and edit lib/BBS/Web/Dispatcher.pm like following:

.. literalinclude:: pl/BBS/lib/BBS/Web/Dispatcher.pm

Edit template
--------------

Open and edit tmpl/index.tt like following:

.. literalinclude:: pl/BBS/tmpl/index.tt

That's all.
-----------

Yes, Amon2 is pretty easy!

