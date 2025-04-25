package Scraper::Runtime::Bootstrap;

use strict;
use warnings;
use IO::Handle;
use FindBin;
use lib "$FindBin::Bin/lib";

sub initialize {

    # Force unbuffered output for correct log ordering
    STDOUT->autoflush(1);
    STDERR->autoflush(1);

    if (!defined $ENV{PERL5LIB}) {
        print STDERR "[Bootstrap] WARNING: PERL5LIB not set. Proceeding anyway.\n";
    }

    print STDERR "[Bootstrap] Environment initialization complete.\n";
    
    return;
}

1;
