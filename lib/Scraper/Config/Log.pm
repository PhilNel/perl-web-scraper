package Scraper::Config::Log;

use Moo;
use Scraper::Config::Base;
extends 'Scraper::Config::Base';

has level => (
    is => 'ro',
    default => sub { $ENV{LOG_LEVEL} // 'DEBUG' },
);

1;