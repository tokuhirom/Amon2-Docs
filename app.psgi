# taken from http://beta.metacpan.org/source/JHTHORSEN/Plack-App-File-DirectoryIndex-0.10/lib/Plack/App/File/DirectoryIndex.pm
package Plack::App::File::DirectoryIndex;
use strict;
use warnings;
use Carp qw/confess/;
use Plack::Util::Accessor qw(index_files);
 
use base 'Plack::App::File';
 
our $VERSION = eval '0.10';
 
my $DEFAULT_INDEX_FILES = ['index.html'];
 
 
sub new {
    my $class = shift;
    my $self = $class->SUPER::new(@_);
 
    if(!$self->{'index_files'}) {
        $self->{'index_files'} = $DEFAULT_INDEX_FILES;
    }
    elsif(ref $self->{'index_files'} ne 'ARRAY') {
        $self->{'index_files'} = [$self->{'index_files'}];
    }
 
    if($self->{'file'}) {
        confess "$class->new() does not accept 'file'. Use 'root' instead";
    }
    if(!defined $self->{'root'}) {
        confess "$class->new() require 'root' attribute";
    }
 
    return $self;
}
 
 
sub should_handle {
    my($self, $file) = @_;
    return $self->SUPER::should_handle($file) || -d $file;
}
 
 
sub serve_path {
    my($self, $env, $file) = @_;
 
    if(-f $file) {
        return $self->SUPER::serve_path($env, $file);
    }
    if(!-d $file) {
        return $self->return_404;
    }
 
    for my $index (@{ $self->index_files }) {
        next unless(-f "$file/$index");
        return $self->SUPER::serve_path($env, "$file/$index");
    }
 
    return $self->return_403;
}
 
1;

my $app = Plack::App::File::DirectoryIndex->new(
    root        => './build/html/',
    index_files => [qw/index.html/]
);

