package LocalFileProvider;

use Moo;
use Carp;

has file_path => (
    is => 'ro',
    required => 1,
);

sub get_html {
    my ($self) = @_;
    my $file_path = $self->file_path;

    open my $file_handle, '<', $file_path or croak "Could not open $file_path: $!";
    local $/; # Slurp mode to read entire file at once
    my $html_content = <$file_handle>;
    close $file_handle;

    return $html_content;
}

1;