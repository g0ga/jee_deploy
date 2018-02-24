package JEEDeploy::Server;

use Moose;
with 'Role::DataObject';

use Module::Load;

sub deploy   { shift->_process('deploy',   @_); }
sub undeploy { shift->_process('undeploy', @_); }


sub _process {
    my $self   = shift;
    my $method = shift;

    my $module = "JEEDeploy::Server::" . $self->db_object->type;
    load($module);
    $module->new(server => {$self->db_object->get_columns})->$method(@_);
}

__PACKAGE__->meta->make_immutable;