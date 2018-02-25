SHELL := /usr/bin/env bash

all: installdeps_quick rebuild_db rebuild_schema

migrate: rebuild_db rebuild_schema

rebuild_db:
	@sqlite3 ./database/config.sqlite < ./database/structure.sql

rebuild_schema:
	@perl -MDBIx::Class::Schema::Loader=make_schema_at,dump_to_dir:./lib -e \
	'make_schema_at("JEEDeploy::Schema", { debug => 1 }, [ "dbi:SQLite:dbname=./database/config.sqlite","","" ])'

installdeps:
	@cpanm --installdeps .

installdeps_quick:
	@cpanm --installdeps --notest --without-recommend --without-suggests .

test:
	@prove -vmr
