package JEEDeploy::App;

use Moose;
with 'Role::DataObject';

use v5.20;
use strictures 2;

use DateTime;
use Digest::MD5::File qw( file_md5_hex );
use JEEDeploy::Server;


sub deploy {
    my ($class, %args) = @_;

    die "No target server specified" unless $args{server_alias};
    my $hash = file_md5_hex($args{filename});

    die "Same app version is already deployed to target server"
        if $class->new_from_search(%args, hash => {'!=' => $hash });

    my $server = JEEDeploy::Server->new(alias => $args{server_alias});
    die "Server not found" unless $server;

    $server->deploy($args{filename});
    $class->add(%args, hash => $hash, datetime);

}

__PACKAGE__->meta->make_immutable;