use strict;
use warnings;
use Test::More;

use Scraper::Parser::DuckDuckGoParser;

# --- Sample HTML snippet with minimal job structure ---
my $html = <<'HTML';
<h2 class="openPositions_department__WDYK7">Engineering - Android</h2>
<article typeof="JobPosting">
  <header>
    <h3 class="openPositions_title__KiGPr">Senior Android Engineer</h3>
  </header>
</article>
<h2 class="openPositions_department__WDYK7">Engineering - Backend Engineering</h2>
<article typeof="JobPosting">
  <header>
    <h3>Senior Backend Engineer</h3>
  </header>
</article>
HTML
my $parser = Scraper::Parser::DuckDuckGoParser->new;

my @jobs   = $parser->parse_jobs($html);

ok(scalar @jobs == 2,    'Parsed exactly two jobs');
is($jobs[0]{title},      'Senior Android Engineer',           'First title correct');
is($jobs[0]{department}, 'Engineering - Android',             'First department correct');
is($jobs[1]{title},      'Senior Backend Engineer',           'Second title correct');
is($jobs[1]{department}, 'Engineering - Backend Engineering', 'Second department correct');

done_testing;
