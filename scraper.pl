#!/usr/bin/env perl
use FindBin;
use lib "$FindBin::Bin/local/lib/perl5";
use strict;
use warnings;
use LWP::UserAgent;

my $user_agent = LWP::UserAgent->new;
my $url = 'https://duckduckgo.com/hiring';
my $response = $user_agent->get($url);

if ($response->is_success) {
    print $response->decoded_content;
} else {
    die "HTTP GET error: ", $response->status_line;
}