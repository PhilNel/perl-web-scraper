package Scraper::Store::DynamoJobStore;

use Moo;
with 'Scraper::Store::JobStore';

use Paws;
use Data::Dumper;
use Carp;
use Scraper::Util::IdGenerator qw(generate_job_id);
use Scraper::Config::Dynamo;

my $log = Scraper::Logger::Factory->get_logger('DynamoJobStore');

has config => (
    is      => 'ro',
    default => sub { Scraper::Config::Dynamo->new }
);

has dynamo_client => (
    is      => 'lazy',
    builder => '_build_dynamo_client',
);

sub _build_dynamo_client {
    my ($self) = @_;

    my $region = $self->config->aws_region;
    $log->debug("Connecting to DynamoDB at host: dynamodb.$region.amazonaws.com");
    
    return Paws->service('DynamoDB', region => $region);
}

sub store_job {
    my ($self, $job) = @_;

    $job->{job_id} ||= generate_job_id($job);

    my $item = $self->_marshall_item({
        job_id     => $job->{job_id},
        title      => $job->{title},
        department => $job->{department},
        company    => $job->{company},
    });

    my $table_name = $self->config->store_table_name
        or croak "Missing STORE_DYNAMO_TABLE_NAME";

    $log->debug("Preparing to insert item: " . Dumper($item));

    eval {
        my $result = $self->dynamo_client->PutItem(
            TableName => $table_name,
            Item      => $item,
        );
        $log->debug("PutItem result: " . Dumper($result));
        1;
    } or do {
        my $error = $@ || 'Unknown error';
        $log->error("DynamoDB insert failed: $error");
    };

    return;
}

sub _marshall_item {
    my ($self, $data) = @_;

    my %item;
    for my $k (keys %$data) {
        next unless defined $data->{$k};
        $item{$k} = { S => $data->{$k} };
    }

    return \%item;
}

1;