use strict;
use warnings;
use Test::More;

use Scraper::Parser::PostHogParser;

my $html = <<'HTML';
<button class="w-full flex flex-col text-left px-2 py-1 rounded border border-b-3">
    <span class="font-semibold text-[15px] ">
        Product Engineer
    </span>
    <span class="text-[13px] text-black/50 dark:text-white/50">
        Multiple teams
    </span>
</button>
HTML

my $parser = Scraper::Parser::PostHogParser->new;
my @jobs   = $parser->parse_jobs($html);

is(scalar @jobs, 1, 'Parsed exactly one job');
is($jobs[0]{title}, 'Product Engineer', 'Job title is correct');
is($jobs[0]{department}, 'Multiple teams', 'Department is correct');
is($jobs[0]{company}, 'PostHog', 'Company name is correct');

done_testing;
