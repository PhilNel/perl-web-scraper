package Scraper::Config::Base;

use Moo;
use Dotenv;

BEGIN {
    Dotenv->load('.env') if -e '.env';
}

1;