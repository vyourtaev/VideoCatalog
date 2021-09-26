#!/usr/bin/env perl
#
use strict;
use warnings;
use Data::Dumper;

use VideoCatalog::Schema;

my $schema = VideoCatalog::Schema->connect('dbi:SQLite:db/auth.db');
my @users = $schema->resultset('User')->all;

foreach my $user (@users) {
   $user->password('admin');
   $user->update;
}

