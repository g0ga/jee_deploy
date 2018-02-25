package JEEDeploy::App;

use Moose;
with 'Role::DataObject';

use v5.20;
use strictures 2;

use DateTime;
use Digest::MD5::File;
use File::Basename;
use JEEDeploy::Env;
use JEEDeploy::Server;


sub deploy {
    my ($class, %args) = @_;

    die "No target server specified" unless $args{server_alias};
    my $server = JEEDeploy::Server->new(alias => $args{server_alias});

    my $hash = Digest::MD5::File::file_md5_hex($args{filename});

    die "Same app version is already deployed to target server"
        if $class->new_from_search(%args, hash => $hash, filename => basename($args{filename}));

    $server->deploy($args{filename});
    $class->modify(
        %args,
        filename => basename($args{filename}),
        hash => $hash,
        datetime => JEEDeploy::Env->now->strftime('%F %T.%9N')
    );
}

sub undeploy {
    my ($class, %args) = @_;

    die "No target server specified" unless $args{server_alias};
    my $server = JEEDeploy::Server->new(alias => $args{server_alias});

    die "App was never deployed to given server"
        if !$class->new_from_search(%args, filename => basename($args{filename}));

    $server->undeploy($args{filename});
    $class->delete(%args, filename => basename($args{filename}));
}

sub ping {
    my ($class, %args) = @_;

    die "No target server specified" unless $args{server_alias};
    my $server = JEEDeploy::Server->new(alias => $args{server_alias});

    die "App was never deployed to given server"
        if !$class->new_from_search(%args, filename => basename($args{filename}));

    $server->ping_app($args{filename});
}

__PACKAGE__->meta->make_immutable;