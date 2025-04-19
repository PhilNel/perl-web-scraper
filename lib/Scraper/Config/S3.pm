package Scraper::Config::S3;

use Moo;
use Scraper::Config::Base;
extends 'Scraper::Config::Base';

has provider_s3_bucket_name => (
    is => 'ro',
    default => sub { $ENV{PROVIDER_S3_BUCKET_NAME} },
);

has provider_s3_bucket_key => (
    is      => 'ro',
    default => sub {
        return $ENV{PROVIDER_S3_BUCKET_KEY} // 'rendered.html';
    },
);

has aws_access_key_id => (
    is      => 'ro',
    default => sub { $ENV{AWS_ACCESS_KEY_ID} },
);

has aws_secret_access_key => (
    is      => 'ro',
    default => sub { $ENV{AWS_SECRET_ACCESS_KEY} },
);

has aws_region => (
    is      => 'ro',
    default => sub {
        return $ENV{AWS_REGION} // 'af-south-1';
    },
);

1;
