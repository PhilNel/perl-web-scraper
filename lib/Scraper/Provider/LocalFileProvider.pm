package Scraper::Provider::LocalFileProvider;

use Moo;
use Carp;

with 'Scraper::Provider::JobProvider';

has config => (
    is      => 'ro',
    default => sub { Scraper::Config::File->new },
);

sub get_html {
    my ($self) = @_;
    my $file_path = $self->config->html_path
        or croak "Missing SCRAPER_HTML_PATH";

    open my $file_handle, '<', $file_path or croak "Could not open $file_path: $!";
    local $/; # Slurp mode to read entire file at once
    my $html_content = <$file_handle>;
    close $file_handle;

    return $html_content;
}

1;