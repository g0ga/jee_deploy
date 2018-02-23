SHELL := /usr/bin/env bash

all: rebuild_db rebuild_schema

rebuild_db:
	@read -p "This will destroy all data in DB. Are you sure [y/n]? " -r;     \
	if [[ $$REPLY =~ ^[Yy]$$ ]];                                              \
	then                                                                      \
	    rm ./database/config.sqlite;                                          \
		sqlite3 ./database/config.sqlite < ./database/structure.sql;          \
	fi

rebuild_schema:
	@perl -MDBIx::Class::Schema::Loader=make_schema_at,dump_to_dir:./lib -e \
	'make_schema_at("JEEDeploy::Schema", { debug => 1 }, [ "dbi:SQLite:dbname=./database/config.sqlite","","" ])'