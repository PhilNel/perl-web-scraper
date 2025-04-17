package DuckDuckGoParser;

use Mojo::DOM;
use Moo;
use Carp;

sub parse_jobs {
    my ($self, $html_content) = @_;
    croak "Missing HTML content" unless $html_content;

    my $dom = Mojo::DOM->new($html_content);
    my @jobs;

    my @department_elements = $dom->find('h2')->grep(sub {
        $_->attr('class') && $_->attr('class') =~ /openPositions_department/
    })->each;

    for my $department_element (@department_elements) {
        my $department_name = $department_element->all_text;
        my $next_element    = $department_element->next;

        while ($next_element) {
            my $is_article_tag = $next_element->tag eq 'article';
            my $is_job_posting = ($next_element->{typeof} // '') eq 'JobPosting';

            last unless $is_article_tag && $is_job_posting;

            my $title_element = $next_element->at('h3');
            my $job_title     = $title_element ? $title_element->all_text : '[Unkown Title]';

            push @jobs, {
                department => $department_name,
                title      => $job_title,
            };

            $next_element = $next_element->next;
        }
    }

    return @jobs;
}

return 1;