## no critic (Modules::RequireExplicitPackage)
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
use lib "$FindBin::Bin/local/lib/perl5";

use Scraper::Factory::ProviderFactory;
use Scraper::Parser::DuckDuckGoParser;
use Scraper::Sink::ConsoleSink;

my $provider = Scraper::Factory::ProviderFactory::build_provider();

my $html_content = $provider->get_html;

my $parser = Scraper::Parser::DuckDuckGoParser->new;
my @jobs = $parser->parse_jobs($html_content);

my $sink = Scraper::Sink::ConsoleSink->new;
$sink->write_jobs(@jobs);

1;