package JEEDeploy::Env;

use Moose;
use v5.20;
use strictures 2;

use DateTime;
use Time::HiRes;

my $mocked_dt;
sub now {
    if ($ENV{TEST} && $mocked_dt) {
        return $mocked_dt->clone;
    } else {
        DateTime->from_epoch(epoch => Time::HiRes::time());
    }
}

sub mock_datetime {
    my ($class, $dt) = @_;
    $mocked_dt = $dt;
}

sub mock_datetime_now {
    my ($class) = @_;
    $mocked_dt = DateTime->from_epoch(epoch => Time::HiRes::time());
}

sub stop_mocking_datetime {
    my ($class) = @_;
    $mocked_dt = undef;
}

sub is_mocking_datetime { return !!$mocked_dt; }

__PACKAGE__->meta->make_immutable;


1;