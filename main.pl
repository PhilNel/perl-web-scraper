use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
use lib "$FindBin::Bin/local/lib/perl5";

use LocalFileProvider;
use DuckDuckGoParser;
use ConsoleSink;

my $file_provider = LocalFileProvider->new(
    file_path => "$FindBin::Bin/../node-web-fetcher/src/rendered.html"
);

my $html_content = $file_provider->get_html;

my $parser = DuckDuckGoParser->new;
my @jobs = $parser->parse_jobs($html_content);

my $sink = ConsoleSink->new;
$sink->write_jobs(@jobs);
