package Scraper::Util::BucketKey;

use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(parse_company_name_from_key);

sub parse_company_name_from_key {
    my ($key) = @_;
    my ($company) = split('/', $key, 2);
    die "Invalid key format: $key" unless defined $company && $company ne '';
    return $company;
}

1;
