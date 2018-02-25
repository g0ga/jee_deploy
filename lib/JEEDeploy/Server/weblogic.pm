package JEEDeploy::Server::weblogic;

use Moose;
use v5.20;
use strictures 2;

with 'Role::ServerPlugin';

sub deploy {
    say "DEPLOYING WEBLOGIC";
}

sub undeploy {
    say "UNDEPLOYING WEBLOGIC";
}

sub ping_app {
    say "PING WEBLOGIC";
}

__PACKAGE__->meta->make_immutable;