package JEEDeploy::DB;

use v5.20;
use strictures 2;

use DBI;
use File::Slurper 'read_text';
use FindBin;

use JEEDeploy::Schema;

sub dbh {
    my $class = shift;

    my $db_name = $ENV{TEST} ? 'config_test.sqlite' : 'config.sqlite';
    my $full_db_name = $ENV{DB_FILE} || "$ENV{PROJECT_ROOT}/database/$db_name";
    my $is_new_db = 1 if ! -e $full_db_name;

    state $dbh = DBI->connect_cached(
        "dbi:SQLite:dbname=$full_db_name",
        "",
        "",
        {
            RaiseError                       => 1,
            AutoCommit                       => 1,
            AutoInactiveDestroy              => 1,
            sqlite_allow_multiple_statements => 1,
        }
    );

    $class->seed_db($dbh) if $is_new_db;

    return $dbh;
}

sub schema {
    my $dbh = shift->dbh;
    return JEEDeploy::Schema->connect(sub { $dbh });
}

sub seed_db {
    my ($class, $dbh) = @_;
    $dbh->do(read_text("$ENV{PROJECT_ROOT}/database/structure.sql"));
}

1;