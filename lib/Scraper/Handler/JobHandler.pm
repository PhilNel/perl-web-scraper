package Scraper::Handler::JobHandler;

use Moo;
use Scraper::Logger::Factory;
use Scraper::Util::BucketKey qw(parse_company_name_from_key);
use Scraper::Parser::ParserFactory;

has provider => (
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

    my $key     = $event->{detail}->{object}->{key};
    my $company = parse_company_name_from_key($key);
    my $parser  = Scraper::Parser::ParserFactory->new->get_parser($company);

    my $html_content = $self->provider->get_html($key);
    my @jobs = $parser->parse_jobs($html_content);

    $self->sink->write_jobs(@jobs);

    $log->info("Completed");

    return;
}

1;
