package BBS::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'BBS::DB::Row';

table {
    name 'sessions';
    pk 'id';
    columns qw(session_data);
};

table {
    name 'entry';
    pk 'entry_id';
    columns qw(entry_id body);
};

1;
