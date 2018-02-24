package JEEDeploy::Server::weblogic;

use Moose;
use strictures 2;

with 'Role::Server';

sub deploy {
    say "DEPLOYING WEBLOGIC";
}

sub undeploy {
    say "UNDEPLOYING WEBLOGIC";
}

__PACKAGE__->meta->make_immutable;