Create BBS site - tutorial
==========================

Create skeleton
--------------

Just type::

    % amon2-setup.pl --dispatcher=Lite BBS

Setup database
---------------

Put sql/sqlite3.sql.

.. literalinclude:: pl/BBS/sql/sqlite3.sql

and type

    % sqlite3 development.db <  sql/sqlite3.sql

You can find the configuration about RDBMS is config/development.pl

.. literalinclude:: pl/BBS/config/development.pl

Run the web server
------------------

You can run the testing web server with following command::

    % plackup BBS.psgi
    HTTP::Server::PSGI: Accepting connections at http://0:5000/

Then, you can access the http://0.5000/ for testing.

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

