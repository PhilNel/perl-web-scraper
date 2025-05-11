package Scraper::Parser::ParserFactory;

use Moo;
use Carp;
use Scraper::Parser::DuckDuckGoParser;

sub get_parser {
    my ($self, $company) = @_;

    return Scraper::Parser::DuckDuckGoParser->new() if $company eq 'duckduckgo';

    croak "No parser available for company: $company";
}

1;
