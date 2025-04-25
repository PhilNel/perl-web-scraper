package Scraper::Provider::ProviderFactory;

use Moo;
use Carp;
use Scraper::Config::App;

sub build_provider {
    my $app_config = Scraper::Config::App->new;
    my $type = $app_config->provider_type;

    if ($type eq 's3') {
        require Scraper::Config::S3;
        require Scraper::Provider::S3Provider;
        return Scraper::Provider::S3Provider->new(
            config => Scraper::Config::S3->new
        );
    }
    elsif ($type eq 'file') {
        require Scraper::Config::File;
        require Scraper::Provider::LocalFileProvider;
        return Scraper::Provider::LocalFileProvider->new(
            config => Scraper::Config::File->new
        );
    }

    croak "Unknown provider type: $type";
}

1;