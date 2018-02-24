package JEEDeploy::Server::glassfish;

use Moose;
use strictures 2;

with 'Role::ServerPlugin';

sub deploy {
    say "DEPLOYING GLASSFISH";
}

sub undeploy {
    say "UNDEPLOYING GLASSFISH";
}

__PACKAGE__->meta->make_immutable;