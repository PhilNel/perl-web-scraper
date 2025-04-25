.PHONY: install test lint clean fetch parse all

install:
	cpanm --installdeps --notest --local-lib=./local .

test:
	PERL5LIB=local/lib/perl5 prove -l t

lint:
	PERL5LIB=local/lib/perl5 ./local/bin/perlcritic lib/ main.pl

clean:
	rm -rf local

fetch:
	cd ../node-web-fetcher && npm run fetch

parse:
	PERL5LIB=local/lib/perl5 perl main.pl

all: clean install test lint fetch parse
