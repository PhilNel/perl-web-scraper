package Scraper::Config::Dynamo;

use Moo;
use Scraper::Config::Base;
extends 'Scraper::Config::Base';

has aws_region => (
    is      => 'ro',
    default => sub {
        return $ENV{AWS_REGION} // 'af-south-1';
    },
);

has store_table_name => (
    is      => 'ro',
    default => sub { $ENV{STORE_DYNAMO_TABLE_NAME} },
);

1;