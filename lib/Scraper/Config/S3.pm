package Scraper::Config::S3;

use Moo;
use Scraper::Config::Base;
extends 'Scraper::Config::Base';

has provider_s3_bucket_name => (
    is => 'ro',
    default => sub { $ENV{PROVIDER_S3_BUCKET_NAME} },
);

has aws_region => (
    is      => 'ro',
    default => sub {
        return $ENV{AWS_REGION} // 'af-south-1';
    },
);

has debug => (
    is      => 'ro',
    default => sub { $ENV{ENABLE_DEBUG} // 0 },
);

1;
