package Scraper::Config::App;

use Moo;
use Scraper::Config::Base;
extends 'Scraper::Config::Base';

has provider_type => (
    is      => 'ro',
    default => sub { $ENV{SCRAPER_PROVIDER_TYPE} // 'file' },
);

1;
