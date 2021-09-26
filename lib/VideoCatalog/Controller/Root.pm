package VideoCatalog::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

VideoCatalog::Controller::Root - Root Controller for VideoCatalog

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(template => 'index.tt2');
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2

Check if there is a user and, if not, forward to login page

=cut 

sub auto :Private {
    my ( $self, $c ) = @_;

    if ($c->controller eq $c->controller('Login')) {
        return 1;
    }    

    # If a user doesn't exist, force login
    if (!$c->user_exists) {

        # Dump a log message to the development server debug output
        $c->log->debug('***Root::auto User not found, forwarding to /login');

        # Redirect the user to the login page
        $c->response->redirect($c->uri_for('/login'));

        # Return 0 to cancel 'post-auto' processing and prevent use of application
        return 0;
    }

    # User found, so return 1 to continue with processing after this 'auto'
    return 1;
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Vova Yourtaev,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
