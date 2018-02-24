package Role::Server;

use Moose::Role;
use strictures 2;

requires('deploy');
requires('undeploy');

has server => (is => 'rw', isa => 'HashRef', required => 1);

1;