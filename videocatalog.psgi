use strict;
use warnings;

use VideoCatalog;

my $app = VideoCatalog->apply_default_middlewares(VideoCatalog->psgi_app);
$app;

