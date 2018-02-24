package JEEDeploy::DB;

use v5.20;
use strictures 2;

use DBI;
use FindBin;

use JEEDeploy::Schema;

sub dbh {
    my $db_name = $ENV{TEST} ? 'config_test.sqlite' : 'config.sqlite';
    state $dbh = DBI->connect_cached(
        "dbi:SQLite:dbname=$FindBin::Bin/../database/$db_name",
        "",
        "",
        {
            RaiseError                       => 1,
            AutoCommit                       => 1,
            AutoInactiveDestroy              => 1,
            sqlite_allow_multiple_statements => 1,
        }
    );

    return $dbh;
}

sub schema {
    my $dbh = dbh();
    return JEEDeploy::Schema->connect(sub { $dbh });
}

1;