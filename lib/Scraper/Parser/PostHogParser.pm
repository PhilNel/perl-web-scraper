package Scraper::Parser::PostHogParser;

use Mojo::DOM;
use Moo;
use Carp;

use Scraper::Util::Text qw(trim);

with 'Scraper::Parser::JobParser';

sub parse_jobs {
    my ($self, $html_content) = @_;
    croak "Missing HTML content" unless $html_content;

    my $dom = Mojo::DOM->new($html_content);
    my @jobs;

    for my $button ($dom->find('button.flex.flex-col.text-left.px-2.py-1')->each) {
        my @spans = $button->find('span')->each;
        next unless @spans >= 2;

        my $job_title = trim($spans[0]->all_text // '');
        my $department = trim($spans[1]->all_text // '');

        next if $job_title eq '' || $department eq '';

        push @jobs, {
            title      => $job_title,
            department => $department,
            company    => 'PostHog',
        };
    }

    return @jobs;
}

1;
