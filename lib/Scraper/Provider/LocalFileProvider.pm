package Scraper::Provider::LocalFileProvider;

use Moo;
use Carp;

with 'Scraper::Provider::JobProvider';

sub get_html {
    my ($self, $path) = @_;

    open my $file_handle, '<', $path or croak "Could not open $path: $!";
    local $/; # Slurp mode to read entire file at once
    my $html_content = <$file_handle>;
    close $file_handle;

    return $html_content;
}

1;