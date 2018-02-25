package JEEDeploy::Server::glassfish;

use Moose;
use v5.20;
use strictures 2;

with 'Role::ServerPlugin';

sub deploy {
    say "DEPLOYING GLASSFISH";
}

sub undeploy {
    say "UNDEPLOYING GLASSFISH";
}

sub ping_app {
    say "PING GLASSFISH";
}

__PACKAGE__->meta->make_immutable;