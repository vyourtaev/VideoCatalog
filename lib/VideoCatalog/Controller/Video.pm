package VideoCatalog::Controller::Video;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

VideoCatalog::Controller::Video - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

The common logic to start chained dispatch here

=cut

sub base :Chained('/') :PathPart('video') :CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->stash(resultset => $c->model('VideoDB::Video'));
}


=head2 list

=cut

# sub list :Local {
sub list :Chained('base'): PathPart('list'): Args() {
    my ( $self, $c, $order_by ) = @_;

    $c->log->debug("Order_by ".$order_by);
    
    my $page = $c->req->params->{page} || 1; 

    my $rs = $c->stash->{resultset}->search(
	    undef, 
	    {
		    page => $page,
		    rows => 10,
		    order_by => "$order_by"
	    },
    );

    $c->stash(videos => [$rs->all]);
    $c->stash(pager => $rs->pager);

    $c->stash(template => 'video/list.tt2');
}

=head2 add

add a new video to the catalog

=cut

sub add :Chained('base') :PathPart('add') :Args(4) {
    my ( $self, $c, $title, $release, $format, $stars ) = @_;

    my $video = $c->model('VideoDB::Video')->update_or_create({
	title => $title,
	release => $release,
	format => $format,
	stars => $stars
	});

    $c->response->header('Cache-Control' => 'no-cache');

}

=head2 delete

Delete a video 

=cut

sub delete :Chained('base') :PathPart('delete') :Args(1) {
    my ($self, $c, $id) = @_;

    $c->stash->{resultset}->find($id)->delete;
    $c->stash->{status_msg} = "Book deleted.";

    # Forward to the list action/method in this controller
    $c->response->redirect($c->uri_for($self->action_for('list')));
}

=head2 form_submit

form submit

=cut

sub form_submit :Chained('base') :PathPart('form_submit') :Args(0) {
    my ( $self, $c, $title, $release, $format, $stars ) = @_;

    my $title     = $c->request->params->{title}	|| 'N/A';
    my $release   = $c->request->params->{release}	|| 'N/A';
    my $format    = $c->request->params->{format}	|| 'N/A';
    my $stars     = $c->request->params->{stars}	|| 'N/A';


    my $video = $c->model('VideoDB::Video')->update_or_create({
	title => $title,
	release => $release,
	format => $format,
	stars => $stars
	});

    $c->response->redirect($c->uri_for($self->action_for('list')));
}

=head2 form_create

Display form to input inforamtion about video to create

=cut

sub form_create :Chained('base') :PathPart('form_create') :Args(0) {
    my ($self, $c) = @_;

    $c->stash(template => 'video/form_create.tt2');
}

=head2 form_upload

Display form to upload file about video 

=cut

sub form_upload :Chained('base') :PathPart('form_upload') :Args(0) {
    my ($self, $c) = @_;

    $c->stash(template => 'video/form_upload.tt2');
}

=head2 form_upload_submit

Submit form for upload video file  

=cut

sub form_upload_submit :Chained('base') :PathPart('form_upload_submit') :Args(0) {

    my ($self, $c) = @_;

       if ( $c->request->parameters->{form_upload} eq 'yes' ) {

           if ( my $upload = $c->request->upload('form_file') ) {

              my $file_handle = $upload->fh;

	      my @upload_content;
	      my $tmp_video = {};

              while ( <$file_handle>) {
                 chomp; 
		 unless($_ =~/^$/) {
                     my ($key,$val) = split /:/;
		     $key = (split / /, $key)[0];
		     $key =~ s/^\s+|\s+$//g;
		     $val =~ s/^\s+|\s+$//g;
		     $tmp_video->{lc($key)} = $val;
		 } else {
                     push @upload_content, $tmp_video;
		     undef $tmp_video;
                 }
	      } 

	      my $video = $c->model('VideoDB::Video')->populate(\@upload_content);

           }
        }

    $c->response->header('Cache-Control' => 'no-cache');
    $c->response->redirect($c->uri_for($self->action_for('list')));
}

=head2 

List recently created video 

=cut

sub list_recent :Chained('base') :PathPart('list_recent') :Args(1) {
    my ($self, $c, $mins) = @_;
 
    $c->stash(videos => [$c->model('VideoDB::Video')
                            ->created_after(DateTime->now->subtract(minutes => $mins))]);
 
    $c->stash(template => 'video/list.tt2');
 }


=head2 

Search by title

=cut

sub search_by_title :Chained('base') :PathPart('search_by_title') :Args(0) {
    my ( $self, $c ) = @_;

    my $search_pattern  = $c->request->params->{search_pattern}	|| 'N/A';

    $c->stash(videos => [
            $c->model('VideoDB::Video')
		->search_by_actor($search_pattern)
        ]);

    $c->stash(template => 'video/list.tt2');
}

=head2

Search by Actor

=cut


sub search_by_actor :Chained('base') :PathPart('search_by_actor') :Args(0) {
    my ( $self, $c ) = @_;

    my $search_pattern  = $c->request->params->{search_pattern}	|| 'N/A';

    $c->stash(videos => [ $c->model('VideoDB::Video')
		    ->search_by_actor($search_pattern)
        ]);

    $c->stash(template => 'video/list.tt2');
}

=head2

Search by

=cut


sub search_by :Chained('base') :PathPart('search_by') :Args(0) {
    my ( $self, $c ) = @_;

    my $search_pattern  = $c->request->params->{search_pattern}	|| 'N/A';
    my $search_by	= $c->request->params->{search_by}	|| 'N/A';

    if($search_by == 1) {
        $c->stash(videos => [ $c->model('VideoDB::Video')
		    ->search_by_title($search_pattern)
        ]);
    } elsif( $search_by == 2 ) {
        $c->stash(videos => [ $c->model('VideoDB::Video')
		    ->search_by_actor($search_pattern)
        ]);
    } else {
       $c->stash->{error_msg} = "Pattern invalid";
    }

    $c->stash(template => 'video/list.tt2');
}

=encoding utf8

=head1 AUTHOR

Vova Yourtaev,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
