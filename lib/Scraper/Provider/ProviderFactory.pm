package Scraper::Provider::ProviderFactory;

use Moo;
use Carp;
use Scraper::Config::App;

my $log = Scraper::Logger::Factory->get_logger('ProviderFactory');

sub build_provider {
    my $app_config = Scraper::Config::App->new;
    my $type = $app_config->provider_type;
    $log->info("Provider type: $type");
    if ($type eq 's3') {
        $log->info("Creating S3 Provider");
        require Scraper::Config::S3;
        require Scraper::Provider::S3Provider;
        return Scraper::Provider::S3Provider->new(
            config => Scraper::Config::S3->new
        );
    }
    elsif ($type eq 'file') {
        $log->info("Creating File Provider");
        require Scraper::Provider::LocalFileProvider;
        return Scraper::Provider::LocalFileProvider->new();
    }

    croak "Unknown provider type: $type";
}

1;