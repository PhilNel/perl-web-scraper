package Scraper::Runner::RunnerFactory;

use strict;
use warnings;

use Scraper::Config::Runtime;
use Scraper::Runner::LocalRunner;
use Scraper::Runner::LambdaRunner;

sub build_runner {
    my $config = Scraper::Config::Runtime->new;

    if ($config->lambda_runtime_api) {
        return Scraper::Runner::LambdaRunner->new(
            runtime_config => $config,
        );
    } else {
        return Scraper::Runner::LocalRunner->new();
    }
}

1;
