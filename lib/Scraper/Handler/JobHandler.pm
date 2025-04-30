package Scraper::Handler::JobHandler;

use Moo;

has provider => (
    is => 'ro',
     required => 1
);

has parser => (
    is => 'ro', 
    required => 1
);

has sink => (
    is => 'ro', 
    required => 1
);

my $log = Scraper::Logger::Factory->get_logger('JobHandler');

sub handle {
    my ($self, $event) = @_;


    $log->info("Starting");

    my $html_content = $self->provider->get_html;
    my @jobs = $self->parser->parse_jobs($html_content);
    $self->sink->write_jobs(@jobs);

    $log->info("Completed");

    return;
}

1;
