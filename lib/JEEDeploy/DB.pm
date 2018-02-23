package JEEDeploy::DB;

use v5.20;
use strictures 2;

use DBI;
use FindBin;

use JEEDeploy::Schema;

sub schema {
    my $dbh    = DBI->connect_cached(
        "dbi:SQLite:dbname=$FindBin::Bin/database/config.sqlite",
        "",
        "",
        {
            RaiseError             => 1,
            AutoCommit             => 1,
            AutoInactiveDestroy    => 1,
        }
    );

    JEEDeploy::Schema->connect(sub { $dbh });
}

1;