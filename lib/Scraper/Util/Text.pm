package Scraper::Util::Text;

use strict;
use warnings;
use Exporter 'import';

our @EXPORT_OK = qw(trim);

sub trim {
    my ($str) = @_;
    return '' unless defined $str;
    $str =~ s/^\s+//;
    $str =~ s/\s+$//;
    return $str;
}

1;
