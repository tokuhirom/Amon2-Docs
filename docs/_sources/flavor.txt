Flavors
=======

This document describes Amon2's Flavor architecture.

Amon2 provides a setup script helper. It was completely rewritten at Amon2 2.60.

Properties
----------

is_standalone
~~~~~~~~~~~~~

Value type: boolean

Is it a standalone flavor? If there is no standalone flavor is loadded, Amon2::Setup loads Amon2::Setup::Flavor::Basic as base flavor automatically.

This property is not mandatory. If there is no method, then it is not a standalone flavor.

Example code is::

    package My::Flavor1;
    sub is_standalone { 1 }

parent
~~~~~~

Value type: list of strings

This property describes parent flavor. There is a example code::

    package My::Flavor1;
    sub parent { qw(Basic) }

Or::

    package My::Flavor2;
    sub parent { qw(+My::Flavor1) }

assets
~~~~~~

Value type: list of strings

You can specify the assets class list::

    package My::Flavor1;
    sub assets { qw(jQuery) }

plugins
~~~~~~~

Value type: list of strings

You can load a plugins by flavor::

    package My::Flavor1;
    sub plugins { qw(Web::JSON) }

context_path
~~~~~~~~~~~~~

This property indicates a path of context class. It is normally lib/<<PATH>>.pm.

web_context_path
~~~~~~~~~~~~~~~~

This property indicates a path of web context class. It is normally lib/<<PATH>>/Web.pm.

Path rewriting
--------------

Amon2::Setup rewrites a template path for normalization.

<<PATH>>
~~~~~~~~

<<PATH>> rewrites as a directory path from module name. e.g. "My/App"::

    lib/<<PATH>>.pm → lib/My/App.pm
    lib/<<PATH>>/Web.pm → lib/My/App/Web.pm

<<WEB_CONTEXT_PATH>>
~~~~~~~~~~~~~~~~~~~~

This indicates a path for web context object. e.g.:

    <<WEB_CONTEXT_PATH>> → lib/<<PATH>>/Web.pm

<<CONTEXT_PATH>>
~~~~~~~~~~~~~~~~

This indicates a path for context object. e.g.:

    <<CONTEXT_PATH>> → lib/<<PATH>>.pm

Templates
---------

You can write a templates on __DATA__ section in Data::Section::Simple's format like::

    package My::Flavor1;
    __DATA__
    @@ lib/<<PATH>>/Web.pm
    : cascade "!";
    : after prepare -> {
    # load all controller classes
    use Module::Find ();
    Module::Find::useall("<: $module :>::DB");
    : }
    @@ t/04_foo.t
    use Test::More;
    ok 1;
    done_testing;

Flavor's template is Text::Xslate. And it uses Kolon syntax for using template cascading.

Template Cascading
~~~~~~~~~~~~~~~~~~

Amon2 uses template cascading for flexible templating in setup script.

Just write a following line to indicate a overriding parent file::

    : cascade "!";

List of overridable block names are available on each flavor's docs.


