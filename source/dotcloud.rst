Setup Amon2 application with Dotcloud
=====================================

This is a simple instlation process for Amon2 on Dotcloud::

    % curl -L http://cpanmin.us/ | perl - Amon2
    % amon2-setup.pl MyApp
    % cde MyApp
    % dotcloud create myapp
    % cat > dotcloud.yml
    www:
      type: perl
    % dotcloud push myapp ./

That's all! You can access to http://myapp-4z7a3pfx.dotcloud.com/!

