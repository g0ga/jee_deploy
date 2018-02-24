#!/usr/bin/ent perl

use v5.20;
use strictures 2;

use FindBin;
use lib "$FindBin::Bin/lib", "$FindBin::Bin/../lib";

use Test::Class::Moose::Load "$FindBin::Bin/lib";
use Test::Class::Moose::Runner;

Test::Class::Moose::Runner->new->runtests;

