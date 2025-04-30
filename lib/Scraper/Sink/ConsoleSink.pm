package Scraper::Sink::ConsoleSink;

use Moo;

with 'Scraper::Sink::JobSink';

my $log = Scraper::Logger::Factory->get_logger('ConsoleSink');

sub write_jobs {
    my ($self, @jobs) = @_;

    if (!@jobs) {
        $log->info("Not jobs to write");
        return;
    }

    for my $job (@jobs) {
        my $department = $job->{department} // '[Unknown Department]';
        my $title      = $job->{title}      // '[Unknown Title]';
        $log->info("📌 $department → $title");
    }

    return;
}

1;