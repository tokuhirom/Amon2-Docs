Profiling
=========

Devel::NYTProf
--------------

You can profile your Amon2 application. My recommend profiling tool is Devel::NYTProf. You can install it as following one liner::

    % curl -LO http://cpanmin.us/ | perl - Devel::NYTProf

And you can profiling your application with following script.

.. literalinclude:: pl/profiling.pl

