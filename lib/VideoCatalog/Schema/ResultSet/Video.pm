package VideoCatalog::Schema::ResultSet::Video;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 search_by_title
 
A predefined search videos by title
 
=cut

sub search_by_title  {
    my ($self, $title_str) = @_;

    return $self->search({
        title => { 'like' => "%$title_str%" }
    });
}

=head2 search_by_actor
 
A predefined search videos by actor
 
=cut

sub search_by_actor  {
    my ($self, $actor_str) = @_;

    return $self->search({
        stars => { 'like' => "%$actor_str%" }
    });
}
 

=head2 created_after

A predefined search for recently added books

=cut

sub created_after {
    my ($self, $datetime) = @_;

    my $date_str = $self->result_source->schema->storage
                          ->datetime_parser->format_datetime($datetime);

    return $self->search({
        created => { '>' => $date_str }
    });
}

sub delete {
    my ($self, $id ) = @_;
    return "Deleted";
}
 
1;
