package Scraper::Provider::S3Provider;

use Moo;
with 'Scraper::Provider::JobProvider';

use Paws;
use Carp;
use Scraper::Config::S3;

has config => (
    is      => 'ro',
    default => sub { Scraper::Config::S3->new }
);

has s3_client => (
    is      => 'lazy',
    builder => '_build_s3_client',
);

sub _build_s3_client {
    my ($self) = @_;

    my $region = $self->config->aws_region;

    return Paws->service('S3', region => $region);
}

sub get_html {
    my ($self, $path) = @_;

    my $bucket_name = $self->config->provider_s3_bucket_name
        or croak "Missing PROVIDER_S3_BUCKET_NAME";

    my $resp = $self->s3_client->GetObject(
        Bucket => $bucket_name,
        Key    => $path,
    );
    unless ($resp) {
        croak "[S3Provider] Failed to fetch S3 object [$bucket_name/$path]: $@";
    }

    my $html_content = $resp->Body;
    unless (defined $html_content) {
        croak "[S3Provider] S3 object [$bucket_name/$path] is empty or unreadable";
    }

    return $html_content;
}

1;