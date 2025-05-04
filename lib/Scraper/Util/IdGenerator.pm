package Scraper::Util::IdGenerator;

use strict;
use warnings;
use Digest::SHA qw(sha256_hex);
use Exporter 'import';

our @EXPORT_OK = qw(generate_job_id);

sub generate_job_id {
    my ($job) = @_;
    return sha256_hex(join '|', @$job{qw/title department company/});
}

1;