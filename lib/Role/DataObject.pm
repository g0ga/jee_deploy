package Role::DataObject;

use Moose::Role;
use strictures 2;

use Carp;
use DDP { output => 'stdout' };
use JEEDeploy::DB;
use DBIx::Class::ResultClass::HashRefInflator;

has db_object => (
    is        => 'rw',
    isa       => 'DBIx::Class::Row',
    required  => 1,
);

around BUILDARGS => sub {
    my ($orig, $class, %args) = @_;

    if (ref($args{db_object}) =~ /JEEDeploy::Schema::Result/) {
        $class->$orig(%args);
    } else {
        my $row = $class->rs->find({%args}, {key => 'primary'});
        die "$class not found" unless $row;
        return $class->$orig(db_object => $row)
    }
};

sub new_from_search {
    my ($class, %args) = @_;
    return map { $class->new(db_object => $_) } $class->rs->search(\%args)->all;
}

sub add {
    my ($class, %args) = @_;

    $class->rs->create(\%args);
}

sub modify {
    my ($class, %args) = @_;

    $class->rs->update_or_create(\%args);
}

sub delete {
    my ($class, %args) = @_;

    die "No args" unless %args;
    $class->rs->search(\%args)->delete_all;
}

sub list {
    my ($class, %args) = @_;

    my @res = $class->rs->search(
        \%args,
        { result_class => 'DBIx::Class::ResultClass::HashRefInflator' }
    );
    p @res;
}

sub rs {
    my ($self) = @_;

    my $class = ref($self) ? ref($self) : $self;
    $class =~ s/.*:://;
    return JEEDeploy::DB->schema->resultset($class);
}

sub columns_info {
    return shift->rs->result_source->columns_info;
}

1;