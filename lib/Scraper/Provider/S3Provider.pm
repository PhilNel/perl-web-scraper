package Scraper::Provider::S3Provider;

use Moo;
use Amazon::S3;
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
    my $debug  = $self->config->debug ? 1 : 0;

    return  Amazon::S3->new({
        aws_access_key_id     => $self->config->aws_access_key_id,
        aws_secret_access_key => $self->config->aws_secret_access_key,
        token                 => $self->config->aws_session_token,
        host                  => "s3.$region.amazonaws.com",
        region                => $self->config->aws_region,
        entry                 => 1,
        debug                 => $debug,
    });
}

sub get_html {
    my ($self) = @_;

    my $bucket_name = $self->config->provider_s3_bucket_name
        or croak "Missing PROVIDER_S3_BUCKET_NAME";
    my $bucket_key = $self->config->provider_s3_bucket_key
        or croak "Missing PROVIDER_S3_BUCKET_KEY";

    my $bucket = $self->s3_client->bucket($bucket_name); 

    unless ($bucket) {
        croak "[S3Provider] Failed to get bucket handle for [$bucket_name]";
    }

    my $html_content = $bucket->get_key($bucket_key);

    unless ($html_content) {
        croak "[S3Provider] Failed to fetch S3 object [$bucket_name/$bucket_key]";
    }

    croak "Failed to fetch S3 object [$bucket_name/$bucket_key]" unless $html_content;

    return $html_content->{value};
}

1;