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

Put the following in sql/sqlite.sql:

.. literalinclude:: pl/BBS/sql/sqlite.sql

And apply the schema:

    % sqlite3 db/development.db < sql/sqlite.sql

You can find the configuration of RDBMS in config/development.pl

.. literalinclude:: pl/BBS/config/development.pl

Run the web server
------------------

You can run the testing web server with the following command::

    % plackup app.psgi
    HTTP::Server::PSGI: Accepting connections at http://0:5000/

, where 5000 is the default port. Then, you can access http://0.5000/ for testing and debugging.

Put Teng schema
---------------

Open and edit lib/BBS/DB/Schema.pm as follows::

.. literalinclude:: pl/BBS/lib/BBS/DB/Schema.pm

Implement controller
--------------------

Open and edit lib/BBS/Web/Dispatcher.pm as follows:

.. literalinclude:: pl/BBS/lib/BBS/Web/Dispatcher.pm

Edit template
--------------

Open and edit tmpl/index.tt as follows:

.. literalinclude:: pl/BBS/tmpl/index.tt

That's all.
-----------

Yes, Amon2 is pretty easy!

