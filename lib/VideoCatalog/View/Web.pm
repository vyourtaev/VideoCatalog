package VideoCatalog::View::Web;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config({
    INCLUDE_PATH => [
        VideoCatalog->path_to( 'root', 'src' ),
        VideoCatalog->path_to( 'root', 'lib' )
    ],
    PRE_PROCESS  => 'config/main',
    WRAPPER      => 'site/wrapper',
    ERROR        => 'error.tt2',
    TIMER        => 0,
    ENCODING     => 'utf8',
    render_die   => 1
});

=head1 NAME

VideoCatalog::View::Web - Catalyst TT Twitter Bootstrap 5 View

=head1 SYNOPSIS

See L<VideoCatalog>

=head1 DESCRIPTION

Catalyst TTSite View.

=head1 AUTHOR

Vova Yourtaev,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

