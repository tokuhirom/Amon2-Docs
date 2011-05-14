Setup Amon2 application with Dotcloud
=====================================

    % curl -L http://cpanmin.us/ | perl - Amon2
    % amon2-setup.pl MyApp
    % dotcloud deploy -t perl tokuhirom.myapp
    % dotcloud push tokuhirom.myapp ./MyApp

That's all! You can access to http://myapp.tokuhirom.dotcloud.com/!

