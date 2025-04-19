package Scraper::Config;
use Moo;

use Dotenv;

BEGIN {
    Dotenv->load;
}

has html_path => (
    is      => 'ro',
    default => sub {
        return $ENV{SCRAPER_HTML_PATH} // "$FindBin::Bin/../node-web-fetcher/rendered.html";
    },
);

1;
