package Scraper::Config::Base;

use Moo;
use Dotenv;

BEGIN {
    Dotenv->load;
}

1;