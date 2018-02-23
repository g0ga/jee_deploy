use utf8;
package JEEDeploy::Schema::Result::App;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

JEEDeploy::Schema::Result::App

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<app>

=cut

__PACKAGE__->table("app");

=head1 ACCESSORS

=head2 filename

  data_type: 'text'
  is_nullable: 0

=head2 server_alias

  data_type: 'text'
  is_nullable: 0

=head2 hash

  data_type: 'text'
  is_nullable: 0

=head2 date

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "filename",
  { data_type => "text", is_nullable => 0 },
  "server_alias",
  { data_type => "text", is_nullable => 0 },
  "hash",
  { data_type => "text", is_nullable => 0 },
  "date",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</filename>

=item * L</server_alias>

=back

=cut

__PACKAGE__->set_primary_key("filename", "server_alias");


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-02-24 12:37:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+IbCLq9g83I99AhS4JFadg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
