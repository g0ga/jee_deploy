package Role::ServerPlugin;

use Moose::Role;
use strictures 2;

use LWP::UserAgent;

requires('deploy');
requires('undeploy');
requires('ping_app');

has server => ( is => 'rw', isa => 'HashRef', required => 1 );
has ua => (
    is       => 'rw',
    isa      => 'LWP::UserAgent',
    required => 1,
    default  => sub { LWP::UserAgent->new }
);

1;
