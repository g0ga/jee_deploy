package JEEDeploy::Server::tomcat;

use Moose;
with 'Role::ServerPlugin';

use v5.20;
use strictures 2;

use LWP::UserAgent;

sub deploy {
    say "DEPLOYING TOMCAT";
}

sub undeploy {
    say "UNDEPLOYING TOMCAT";
}

sub base_url {
}

__PACKAGE__->meta->make_immutable;