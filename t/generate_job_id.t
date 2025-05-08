use strict;
use warnings;
use Test::More;

use Scraper::Util::IdGenerator qw(generate_job_id);

my $job = {
    title      => 'Software Engineer',
    department => 'Engineering',
    company    => 'DuckDuckGo',
};
my $expected = '8a118a0579d79aafd2e59d1928adb5abeb55a8af899cb9aebdd8e3eecc569b4e';

my $actual = generate_job_id($job);

is($actual, $expected, 'Generated ID matches expected SHA-256 hash');

done_testing;
