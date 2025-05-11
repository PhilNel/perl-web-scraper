package Scraper::Runner::LocalRunner;

use Moo;
with 'Scraper::Runner::JobRunner';

use Scraper::Logger::Factory;
use Scraper::Handler::HandlerFactory;

my $log = Scraper::Logger::Factory->get_logger('LocalRunner');

sub run {
    my $self = shift;

    $log->info("Running locally");

    my $handler = Scraper::Handler::HandlerFactory::build_handler();

    my $mock_event = {
        detail => {
            object => {
                key => 'duckduckgo/rendered.html',
            },
        }
    };

    $handler->handle($mock_event);

    $log->info("Job completed successfully");

    return;
}

1;
