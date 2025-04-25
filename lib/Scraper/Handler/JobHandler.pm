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

sub handle {
    my ($self, $event) = @_;

    print STDERR "[Handler] Starting...\n";

    my $html_content = $self->provider->get_html;
    my @jobs = $self->parser->parse_jobs($html_content);
    $self->sink->write_jobs(@jobs);

    print STDERR "[Handler] Completed.\n";

    return;
}

1;
