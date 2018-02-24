SHELL := /usr/bin/env bash

all: installdeps rebuild_db rebuild_schema

migrate: rebuild_db rebuild_schema

rebuild_db:
	@read -p "This will destroy all data in DB. Are you sure [y/N]? " -r;     \
	if [[ $$REPLY =~ ^[Yy]$$ ]];                                              \
	then                                                                      \
		sqlite3 ./database/config.sqlite < ./database/structure.sql;          \
	fi

rebuild_test_db:
	sqlite3 ./database/config_test.sqlite < ./database/structure.sql;

rebuild_schema:
	@perl -MDBIx::Class::Schema::Loader=make_schema_at,dump_to_dir:./lib -e \
	'make_schema_at("JEEDeploy::Schema", { debug => 1 }, [ "dbi:SQLite:dbname=./database/config.sqlite","","" ])'

installdeps:
	@cpanm --installdeps .