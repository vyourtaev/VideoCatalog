use strict;
use warnings;

use Test::More tests => 11;

use Test::WWW::Mechanize;

my $mech = Test::WWW::Mechanize->new( );

$mech->get_ok('http://localhost:3000');

$mech->get_ok('http://localhost:3000/video/list');

$mech->title_is('Video Catalog Example Page');

$mech->get_ok('http://localhost:3000/video/form_create');

$mech->content_contains('form_create');

$mech->get_ok('http://localhost:3000/video/form_upload');

$mech->content_contains('form_upload');

$mech->post_ok('http://localhost:3000/video/form_submit', {
		title => 'Test-Title-1000',
		release =>  2021,
		format => 'DVD',
		stars => 'Jecky Chan' });

$mech->get_ok('http://localhost:3000/video/list');

$mech->post_ok('http://localhost:3000/video/search_by', {
 		search_by => 1,
 		search_pattern => 'Test' });

$mech->delete_ok('http://localhost:3000/video/delete/1', {});
 
# $mech->post_ok('http://localhost:3000/video/form_submit', {
# 		title => 'Test-Title-1000',
# 		release =>  2021,
# 		format => 'DVD',
# 		stars => 'Jecky Chan' });
# 
# 
# $mech->post_ok('http://localhost:3000/video/search_by', {
# 		search_by => 1,
# 		search_pattern => 'Test' });
# 
# $mech->content_contains('Test-Title-1000');

