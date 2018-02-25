package JEEDeploy::Test;

use Test::Class::Moose;
use v5.20;
use strictures 2;

use FindBin;
use JEEDeploy::DB;
use JEEDeploy::Env;

BEGIN {
    $ENV{TEST} = 1;
    $ENV{PROJECT_ROOT} = "$FindBin::Bin/.."
}

sub test_startup {
    my $self = shift;

    $self->next::method;
    my $dbh = JEEDeploy::DB->dbh;
    JEEDeploy::DB->seed_db($dbh);

}

sub test_shutdown {
    my $self = shift;

    $self->next::method;
    my $dbh = JEEDeploy::Env->stop_mocking_datetime();

}

1;