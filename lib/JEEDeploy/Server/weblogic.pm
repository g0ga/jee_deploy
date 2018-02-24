package JEEDeploy::Server::weblogic;

use Moose;
use strictures 2;

with 'Role::Server';

sub deploy {
    say "DEPLOING WEBLOGIC";
}

sub undeploy {
    say "UNDEPLOING WEBLOGIC";
}

__PACKAGE__->meta->make_immutable;