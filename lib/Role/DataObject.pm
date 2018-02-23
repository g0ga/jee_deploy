package Role::DataObject;

use Moose::Role;

use v5.20;
use strictures 2;

use JEEDeploy::DB;
use DBIx::Class::ResultClass::HashRefInflator;

has db_object => (
    is        => 'rw',
    isa       => 'DBIx::Class::Row',
    required  => 1,
);

around new => sub {
    my ($orig, $class, %args) = @_;
    if (ref $args{db_object} eq 'DBIx::Class::Row') {
        $class->$orig(%args);
    } else {
        my $row = $class->rs->find_or_new({%args}, {key => 'primary'});
        return $class->$orig(db_object => $row)
    }
};

sub fetch {
    my ($class, @args) = @_;

    my $row = $class->rs->find(@_);
    return if !$row;
    return $class->new(db_object => $row)
}

sub store {
    my ($self, %args) = @_;

    croak 'Called as class method' unless ref $self;
    $self->db_object->update_or_insert;
}

sub data {
    return $self->db_object->get_columns;
}

sub rs {
    my ($self, $hri) = @_;

    my $class = ref($self) ? ref($self) : $self;
    $class =~ s/.*:://;

    my $server_rs = JEEDeploy::DB->schema->resultset($class);
    if ($hri){
        $server_rs->result_class('DBIx::Class::ResultClass::HashRefInflator')
    }

    return $server_rs;
}

1;