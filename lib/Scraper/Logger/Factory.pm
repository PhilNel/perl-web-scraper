package Scraper::Logger::Factory;

use Moo;
use Carp;

use Scraper::Logger::Log4perlLogger;
use Scraper::Config::Log;

# Internal cache of loggers per tag
my %logger_cache;

my $log_config = Scraper::Config::Log->new();

sub get_logger {
    my ($class, $tag) = @_;

    croak "Logger tag must be provided" unless defined $tag;

    if (exists $logger_cache{$tag}) {
        return $logger_cache{$tag};
    }

    my $logger = Scraper::Logger::Log4perlLogger->new(
        tag   => $tag,
        level => $log_config->level,
    );
    $logger_cache{$tag} = $logger;

    return $logger;
}

1;