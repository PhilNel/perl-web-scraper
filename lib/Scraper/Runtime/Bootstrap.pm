package Scraper::Runtime::Bootstrap;

use strict;
use warnings;
use IO::Handle;
use FindBin;
use lib "$FindBin::Bin/lib";

use Scraper::Logger::Factory;

my $log = Scraper::Logger::Factory->get_logger('Bootstrap');

sub initialize {

    # Force unbuffered output for correct log ordering
    STDOUT->autoflush(1);
    STDERR->autoflush(1);

    if (!defined $ENV{PERL5LIB}) {
        $log->warning('PERL5LIB not set. Proceeding anyway');
    }

    $log->info('Environment initialization complete');
    
    return;
}

1;