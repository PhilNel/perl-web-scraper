use strict;
use warnings;
use Test::More;

use Scraper::Provider::LocalFileProvider;
use Scraper::Config::File;

sub create_temp_html_file {
    use File::Temp qw/tempfile/;
    my ($file_handler, $filename) = tempfile( SUFFIX => '.html', UNLINK => 1 );
    print $file_handler "<html><body>Hello from test</body></html>";
    close $file_handler;

    return $filename;
}

my $filename = create_temp_html_file();
my $config   = Scraper::Config::File->new(html_path => $filename);
my $provider = Scraper::Provider::LocalFileProvider->new(config => $config);

my $html = $provider->get_html;

ok(defined $html, 'HTML content was returned');
like($html, qr/Hello from test/, 'HTML content matches expected string');

done_testing;
