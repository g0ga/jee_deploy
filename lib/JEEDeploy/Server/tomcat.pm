package JEEDeploy::Server::tomcat;

use Moose;
with 'Role::ServerPlugin';

use v5.20;
use strictures 2;

use DDP { output => 'stdout' };
use Data::Dumper;
use HTTP::Request::Common;

sub deploy {
    my ($self, $filename) = @_;

    my $path = $self->path($filename);

    my $req = PUT(
        $self->base_url . "/deploy?path=/$path&update=true",
        Content_Type => 'multipart/form-data',
        Content      => [ file_0 => ["$filename"] ]
    );
    $req->authorization_basic(
        $self->server->{username},
        $self->server->{password}
    );

    my $resp = $self->ua->request($req);
    p $resp if $ENV{DEBUG};
    return $resp->is_success;

}

sub undeploy {
    my ($self, $filename) = @_;

    my $path = $self->path($filename);
    my $req = GET($self->base_url . "/undeploy?path=/$path");
    $req->authorization_basic(
        $self->server->{username},
        $self->server->{password}
    );
    my $resp = $self->ua->request($req);
    p $resp if $ENV{DEBUG};
    return $resp->is_success;
}

sub ping_app {
    my ($self, $filename) = @_;

    my $path = $self->path($filename);
    my $resp = $self->ua->get($self->base_url('nomgmt') . $path);
    p $resp if $ENV{DEBUG};
    return $resp->is_success;
}

sub path {
    my ($self, $filename) = @_;
    my $path = $filename;
    $path =~ s/^.*\///;
    $path =~ s/\.\w+$//;
    return $path if $ENV{DEBUG};;
}

sub base_url {
    my ($self, $nomgmt) = @_;

    return sprintf( 'http://%s:%s/%s',
        $self->server->{hostname},
        $self->server->{port},
        $nomgmt ? '' : $self->server->{mgmt_url}
    );
}

__PACKAGE__->meta->make_immutable;
