package JEEDeploy::Server;

use Moose;
with 'Role::DataObject';

use Module::Load;

sub deploy   { shift->_process('deploy',   @_) or die "Deploy failed"; }
sub undeploy { shift->_process('undeploy', @_) or die "Undeploy failed"; }
sub ping_app { shift->_process('ping_app', @_) or die "App is not running" }


sub _process {
    my $self   = shift;
    my $method = shift;

    my $module = "JEEDeploy::Server::" . $self->db_object->type;
    load($module);
    return $module->new(server => {$self->db_object->get_columns})->$method(@_);
}

__PACKAGE__->meta->make_immutable;