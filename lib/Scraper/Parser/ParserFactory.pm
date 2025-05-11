package Scraper::Parser::ParserFactory;

use Moo;
use Carp;
use Scraper::Parser::DuckDuckGoParser;
use Scraper::Parser::PostHogParser;

sub get_parser {
    my ($self, $company) = @_;

    return Scraper::Parser::DuckDuckGoParser->new() if $company eq 'duckduckgo';
    
    return Scraper::Parser::PostHogParser->new() if $company eq 'posthog';

    croak "No parser available for company: $company";
}

1;
