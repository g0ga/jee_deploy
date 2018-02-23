package MooseX::JEEDeploy::Types;

use strictures 2;

use Moose::Util::TypeConstraints;
use MooseX::Types::Moose qw(Int Str Num ArrayRef);
use MooseX::Types::Structured qw(Dict Optional Map);
use MooseX::Attribute::Deflator;


subtype 'JEEDeploy::Server::Type', enum([qw/tomcat glassfish weblogic/]);


1;