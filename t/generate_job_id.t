use strict;
use warnings;
use Test::More;

use Scraper::Util::IdGenerator qw(generate_job_id);

my $job = {
    title      => 'Senior Backend Engineer',
    department => 'Engineering - Backend Engineering',
    company    => 'DuckDuckGo',
};
my $expected = 'f44efb505a4969fb0dcc565f95fbfd05ad822127c56ca3a63a31b441eb2c376a';

my $actual = generate_job_id($job);

is($actual, $expected, 'Generated ID matches expected SHA-256 hash');

done_testing;
