## no critic (Modules::RequireExplicitPackage)
use strict;
use warnings;

use Scraper::Runtime::Bootstrap;
use Scraper::Runner::RunnerFactory;

Scraper::Runtime::Bootstrap::initialize();

my $runner = Scraper::Runner::RunnerFactory::build_runner();
$runner->run();

1;