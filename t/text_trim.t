use strict;
use warnings;
use Test::More;

use Scraper::Util::Text qw(trim);

is(trim("   hello  "),      "hello",      'Trims leading and trailing spaces');
is(trim("\n\tfoo bar\t\n"), "foo bar",    'Trims mixed whitespace');
is(trim("no-trim"),         "no-trim",    'Unchanged if no surrounding spaces');
is(trim("   "),             "",           'Only spaces becomes empty string');
is(trim(undef),             "",           'Undefined input becomes empty string');

done_testing;
