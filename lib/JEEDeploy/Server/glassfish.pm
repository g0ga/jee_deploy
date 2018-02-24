package JEEDeploy::Server::glassfish;

use Moose;
use strictures 2;

with 'Role::Server';

sub deploy {
    say "DEPLOYING GLASSFISH";
}

sub undeploy {
    say "UNDEPLOYING GLASSFISH";
}

__PACKAGE__->meta->make_immutable;