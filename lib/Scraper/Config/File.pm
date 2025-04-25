package Scraper::Config::File;

use Moo;
use FindBin;
use Scraper::Config::Base;
extends 'Scraper::Config::Base';

has html_path => (
    is      => 'ro',
    default => sub {
        return $ENV{SCRAPER_HTML_PATH} // "$FindBin::Bin/../node-web-fetcher/rendered.html";
    },
);

1;
