package JEEDeploy::Server::glassfish;

use Moose;
use strictures 2;

with 'Role::Server';

sub deploy {
    say "DEPLOING GLASSFISH";
}

sub undeploy {
    say "UNDEPLOING GLASSFISH";
}

__PACKAGE__->meta->make_immutable;