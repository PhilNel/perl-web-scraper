use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
use lib "$FindBin::Bin/local/lib/perl5";

use Scraper::Config;
use Scraper::Provider::LocalFileProvider;
use Scraper::Parser::DuckDuckGoParser;
use Scraper::Sink::ConsoleSink;

my $config = Scraper::Config->new;

my $file_provider = Scraper::Provider::LocalFileProvider->new(
    file_path => $config->html_path
);

my $html_content = $file_provider->get_html;

my $parser = Scraper::Parser::DuckDuckGoParser->new;
my @jobs = $parser->parse_jobs($html_content);

my $sink = Scraper::Sink::ConsoleSink->new;
$sink->write_jobs(@jobs);
