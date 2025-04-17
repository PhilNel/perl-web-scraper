package ConsoleSink;

use Moo;

sub write_jobs {
    my ($self, @jobs) = @_;

    if (!@jobs) {
        print "[INFO] No jobs to write.\n";
        return;
    }

    for my $job (@jobs) {
        my $department = $job->{department} // '[Unknown Department]';
        my $title      = $job->{title}      // '[Unknown Title]';
        print "📌 $department → $title\n";
    }
}

return 1;