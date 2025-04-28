package Scraper::Runner::LocalRunner;

use Moo;
with 'Scraper::Runner::JobRunner';

use Scraper::Handler::HandlerFactory;

sub run {
    my $self = shift;

    print STDERR "[LocalRunner] Running locally...\n";

    my $handler = Scraper::Handler::HandlerFactory::build_handler();
    $handler->handle({});  # Local dummy event

    print STDERR "[LocalRunner] Job completed successfully.\n";
    
    return;
}

1;
