package Scraper::Logger::Log4perlLogger;

use Moo;
with 'Scraper::Logger::Logger';

use Log::Log4perl;

has tag => (
    is       => 'ro',
    required => 1,
);

has level => (
    is => 'ro',
    required => 1,
);

my $logger;

sub BUILD {
    my ($self) = @_;

    unless ($logger) {
        my $conf = qq(
            log4perl.rootLogger              = $self->{level}, Screen
            log4perl.appender.Screen         = Log::Log4perl::Appender::Screen
            log4perl.appender.Screen.stderr  = 0
            log4perl.appender.Screen.layout  = PatternLayout
            log4perl.appender.Screen.layout.ConversionPattern = [%d{yyyy-MM-dd HH:mm:ss.SSS}] [%p] %m%n
        );

        Log::Log4perl::init_once( \$conf );
        $logger = Log::Log4perl->get_logger();
    }

    return;
}

sub _format_msg {
    my ($self, @msgs) = @_;
    return "[$self->{tag}] " . join('', @msgs);
}

sub debug { my ($self, @msgs) = @_; $logger->debug($self->_format_msg(@msgs)); return; }
sub info  { my ($self, @msgs) = @_; $logger->info($self->_format_msg(@msgs)); return; }
sub warning  { my ($self, @msgs) = @_; $logger->warn($self->_format_msg(@msgs)); return; }
sub error { my ($self, @msgs) = @_; $logger->error($self->_format_msg(@msgs)); return; }
sub fatal { my ($self, @msgs) = @_; $logger->fatal($self->_format_msg(@msgs)); return; }

1;