package Scraper::Sink::StoreSink;

use Moo;
with 'Scraper::Sink::JobSink';

use Carp;
use Scraper::Logger::Factory;

my $log = Scraper::Logger::Factory->get_logger('StoreSink');

has store => (
    is       => 'ro',
    required => 1,
);

sub write_jobs {
    my ($self, @jobs) = @_;

    if (!@jobs) {
        $log->info("Not jobs to write");
        return;
    }

    for my $job (@jobs) {
        $self->store->store_job($job);
    }

    return;
}

1;