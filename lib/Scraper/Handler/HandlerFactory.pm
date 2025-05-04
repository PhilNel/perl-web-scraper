package Scraper::Handler::HandlerFactory;

use strict;
use warnings;

use Scraper::Handler::JobHandler;
use Scraper::Provider::ProviderFactory;
use Scraper::Parser::DuckDuckGoParser;
use Scraper::Sink::SinkFactory;

sub build_handler {
    my $provider = Scraper::Provider::ProviderFactory::build_provider();
    my $parser   = Scraper::Parser::DuckDuckGoParser->new();
    my $sink     = Scraper::Sink::SinkFactory->build_sink();

    return Scraper::Handler::JobHandler->new(
        provider => $provider,
        parser   => $parser,
        sink     => $sink,
    );
}

1;
