package JEEDeploy::Test::Deploy;

use Test::Class::Moose extends => 'JEEDeploy::Test';
use v5.20;
use strictures 2;

use Hash::MoreUtils qw(slice_def);
use Digest::MD5::File;
use DateTime;

use JEEDeploy::DB;
use JEEDeploy::App;
use JEEDeploy::Env;
use JEEDeploy::Server;

sub test_startup {
    my $self = shift;

    $self->next::method;

    JEEDeploy::DB->schema->resultset('Server')->create({
        alias    => "tc1",
        type     => "tomcat",
        hostname => "localhost",
        mgmt_url => "_manage",
        username => "admin",
        password => "admin",
    });
}

sub test_app_record_added_after_deployment {
    my $self = shift;

    my $hash = '321';
    no warnings 'redefine';
    local *Digest::MD5::File::file_md5_hex = sub { $hash };
    local *JEEDeploy::Server::deploy       = sub {};
    local *JEEDeploy::Server::undeploy     = sub {};

    my $app_rs = JEEDeploy::DB
        ->schema
        ->resultset('App')
        ->search({}, { order_by => { -desc => 'datetime' }});

    is($app_rs->count, 0, 'app table is empty');
    JEEDeploy::Env->mock_datetime_now;
    JEEDeploy::App->deploy(filename => 'hello.war', server_alias => 'tc1');
    is($app_rs->count, 1, 'record was added');

    eq_or_diff (
        {slice_def({$app_rs->first->get_columns})},
        {
            filename     => 'hello.war',
            server_alias => 'tc1',
            hash         => $hash,
            datetime     => JEEDeploy::Env->now()->strftime('%F %T.%9N'),
        },
        'Data is what we expect'
    );

    JEEDeploy::Env->mock_datetime_now;
    throws_ok(
        sub { JEEDeploy::App->deploy(filename => 'hello.war', server_alias => 'tc1'); },
        qr/is already deployed/,
        'Cannat deploy same app to same server while it is already deployed'
    );
    is($app_rs->count, 1, 'record was not added');

    JEEDeploy::Env->mock_datetime_now;
    $hash = '432';
    JEEDeploy::App->deploy(filename => 'hello.war', server_alias => 'tc1');
    is($app_rs->count, 1, 'no records was created when deploying updated app');
    eq_or_diff (
        {slice_def({$app_rs->first->get_columns})},
        {
            filename     => 'hello.war',
            server_alias => 'tc1',
            hash         => $hash,
            datetime     => JEEDeploy::Env->now()->strftime('%F %T.%9N'),
        },
        'Data is what we expect'
    );

    JEEDeploy::App->undeploy(filename => 'hello.war', server_alias => 'tc1');
    is($app_rs->count, 0, 'App record is being deleted after undeploying');
}

1;