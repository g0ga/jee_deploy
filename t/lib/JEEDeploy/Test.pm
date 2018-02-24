package JEEDeploy::Test;

use Test::Class::Moose;
use v5.20;
use strictures 2;

use File::Slurper 'read_text';
use FindBin;
use JEEDeploy::DB;
use JEEDeploy::Env;

BEGIN { $ENV{TEST} = 1; }

sub test_startup {
    my $self = shift;

    $self->next::method;
    my $dbh = JEEDeploy::DB->dbh;
    $dbh->do(read_text("$FindBin::Bin/../database/structure.sql"));
}

sub test_shutdown {
    my $self = shift;

    $self->next::method;
    my $dbh = JEEDeploy::Env->stop_mocking_datetime();

}

1;