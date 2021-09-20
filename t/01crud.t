use strict;
use warnings;

use Test::More tests => 14;

use Test::WWW::Mechanize;

my $mech = Test::WWW::Mechanize->new( );

$mech->get_ok('http://localhost:3000', 'Conect to Root Controller: http://localhost');

$mech->get_ok('http://localhost:3000/video/list', 'Connect Video Controller: http://localhost/video/list');

$mech->title_is('Video Catalog Example Page');

$mech->get_ok('http://localhost:3000/video/form_create', 'Get form_create URL: http://localhost/form_create');

$mech->content_contains('form_create', 'Get content from form_create');

$mech->get_ok('http://localhost:3000/video/form_upload', 'Get connection to form_upload: http://localhost:3000/videl/form_upload');

$mech->content_contains('form_upload', 'Check content form_upload');

$mech->post_ok('http://localhost:3000/video/form_submit', {
		title => 'Test-Title-1000',
		release =>  2021,
		format => 'DVD',
		stars => 'Jecky Chan' },
	        'Add video submit form http://localhost:3000/video/form_submit'
);

$mech->get_ok('http://localhost:3000/video/list', 'Check added movie http://localhost:3000/video/list');

$mech->post_ok('http://localhost:3000/video/search_by', {
 		search_by => 1,
 		search_pattern => 'Test-Title' }, 'Search movie by Title: http://localhost:3000/video/search_by');

$mech->post_ok('http://localhost:3000/video/search_by', {
 		search_by => 2,
 		search_pattern => 'Jecky Chan' }, 'Search movie by Actor: http://localhost:3000/video/search_by');

$mech->get_ok('http://localhost:3000/video/form_upload', 'Get form_upload http://localhost:3000/video/form_upload');

$mech->submit_form_ok({
		form_number => 2,
		fields => {
                   form_upload => 'yes',
	           form_file => 'uploads.txt'	   
		}, 
	},	'Bulk movie file Uploaded',
);

$mech->get_ok('http://localhost:3000/video/delete/1', 'Delete movie by ID http://localhost:3000/video/delete/1');

