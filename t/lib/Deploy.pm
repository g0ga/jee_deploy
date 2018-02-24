package Test::Deploy;

use Test::Class::Moose extends => 'Test';
use v5.20;
use strictures 2;

use Hash::MoreUtils qw(slice_def);
use Digest::MD5::File;
use DateTime;

use JEEDeploy::DB;
use JEEDeploy::App;

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
    no strict 'refs';
    local *Digest::MD5::File::file_md5_hex = sub { $hash };

    my $app_rs = JEEDeploy::DB->schema->resultset('App');
    is($app_rs->count, 0, 'app table is empty');
    JEEDeploy::App->deploy(filename => 'hello.war', server_alias => 'tc1');
    is($app_rs->count, 1, 'record was added');
    eq_or_diff (
        {slice_def({$app_rs->first->get_columns})},
        {
            filename     => 'hello.war',
            server_alias => 'tc1',
            hash         => $hash,
            datetime     => DateTime->now()->datetime,
        },
        'Data is what we expect'
    );
}

1;