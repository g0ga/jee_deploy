use utf8;
package JEEDeploy::Schema::Result::Server;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

JEEDeploy::Schema::Result::Server

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<server>

=cut

__PACKAGE__->table("server");

=head1 ACCESSORS

=head2 alias

  data_type: 'text'
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 type

  data_type: 'text'
  is_nullable: 0

=head2 hostname

  data_type: 'text'
  is_nullable: 0

=head2 port

  data_type: 'int'
  is_nullable: 1

=head2 username

  data_type: 'text'
  is_nullable: 0

=head2 password

  data_type: 'text'
  is_nullable: 0

=head2 mgmt_url

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "alias",
  { data_type => "text", is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "type",
  { data_type => "text", is_nullable => 0 },
  "hostname",
  { data_type => "text", is_nullable => 0 },
  "port",
  { data_type => "int", is_nullable => 1 },
  "username",
  { data_type => "text", is_nullable => 0 },
  "password",
  { data_type => "text", is_nullable => 0 },
  "mgmt_url",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</alias>

=back

=cut

__PACKAGE__->set_primary_key("alias");


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-02-23 21:42:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vwFKmdgDkw2AupDp9T08RA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
