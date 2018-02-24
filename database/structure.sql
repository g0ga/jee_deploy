CREATE TABLE server (
    alias    TEXT PRIMARY KEY, -- short alias to use from command line
    name     TEXT,             -- full server name (optional)
    type     TEXT NOT NULL,    -- one of tomcat, glassfish, weblogic
    hostname TEXT NOT NULL,    -- servers ip/hostname
    port     INT,              -- application server port (optional)
    username TEXT NOT NULL,    -- application server api username
    password TEXT NOT NULL,    -- application server api password
    mgmt_url TEXT NOT NULL     -- mamenegemt url base path
);

CREATE TABLE app (
    filename     TEXT NOT NULL,
    server_alias TEXT NOT NULL,
    hash         TEXT,
    datetime     TEXT,
    PRIMARY KEY (filename, server_alias)
);
