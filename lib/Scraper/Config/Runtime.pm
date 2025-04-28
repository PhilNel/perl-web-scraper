package Scraper::Config::Runtime;

use Moo;
use Scraper::Config::Base;
extends 'Scraper::Config::Base';

has lambda_runtime_api => (
    is => 'ro',
    default => sub { $ENV{AWS_LAMBDA_RUNTIME_API}},
);

1;