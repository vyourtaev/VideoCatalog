use strict;
use warnings;
use Test::More;


use Catalyst::Test 'VideoCatalog';
use VideoCatalog::Controller::Video;

ok( request('/video/list')->is_success, 'Request should succeed' );
done_testing();
