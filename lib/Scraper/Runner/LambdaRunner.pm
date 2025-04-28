package Scraper::Runner::LambdaRunner;

use Moo;
with 'Scraper::Runner::JobRunner';

use JSON;
use LWP::UserAgent;
use Scraper::Handler::HandlerFactory;

has runtime_config => (
    is => 'ro', 
    required => 1
);

sub run {
    my $self = shift;

    my $runtime_api = $self->runtime_config->lambda_runtime_api;
    my $runtime_url = "http://$runtime_api/2018-06-01/runtime";
    my $ua = LWP::UserAgent->new;

    my $handler = Scraper::Handler::HandlerFactory::build_handler();

    while (1) {
        my $next_response = $ua->get("$runtime_url/invocation/next");

        unless ($next_response->is_success) {
            die "[LambdaRunner] Failed to fetch invocation: " . $next_response->status_line;
        }

        my $request_id = $next_response->header('Lambda-Runtime-Aws-Request-Id');
        my $event_payload = $next_response->decoded_content;

        my $event = eval { decode_json($event_payload) } || {};

        eval {
            $handler->handle($event);
        };
        my $result = $@ ? { statusCode => 500, body => encode_json({ error => $@ }) }
                        : { statusCode => 200, body => encode_json({ message => "Success" }) };

        my $post_response = $ua->post(
            "$runtime_url/invocation/$request_id/response",
            'Content-Type' => 'application/json',
            Content        => encode_json($result)
        );

        unless ($post_response->is_success) {
            die "[LambdaRunner] Failed to POST response: " . $post_response->status_line;
        }
    }

    return;
}

1;
