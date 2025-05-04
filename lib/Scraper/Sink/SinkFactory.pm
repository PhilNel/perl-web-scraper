package Scraper::Sink::SinkFactory;

use Moo;
use Carp;

use Scraper::Config::App;

sub build_sink {
    my $app_config = Scraper::Config::App->new;
    my $type       = $app_config->sink_type;

    if ($type eq 'dynamo') {
        require Scraper::Config::Dynamo;
        require Scraper::Store::DynamoJobStore;
        require Scraper::Sink::StoreSink;
        my $store = Scraper::Store::DynamoJobStore->new(
            config => Scraper::Config::Dynamo->new
        );
        return Scraper::Sink::StoreSink->new(
            store => $store
        );
    }
    elsif ($type eq 'console') {
        require Scraper::Sink::ConsoleSink;
        return Scraper::Sink::ConsoleSink->new();
    }

    croak "Unknown provider type: $type";
}

1;