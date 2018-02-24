package JEEDeploy::Server::tomcat;

use Moose;
with 'Role::Server';

use v5.20;
use strictures 2;

sub deploy {
    say "DEPLOING TOMCAT";
}

sub undeploy {
    say "UNDEPLOING TOMCAT";
}

__PACKAGE__->meta->make_immutable;