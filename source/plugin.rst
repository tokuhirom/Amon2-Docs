Plugin
======

Plugin architecture
-------------------

Amon2's plugin architecture is very simple.

Plugin class MUST implement ``MyPlugin->init($context_class, \%configuration)``. That's all.

``$context_class`` is a class name. It would be child class of the ``Amon2``.

