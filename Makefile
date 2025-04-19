.PHONY: install test clean fetch parse all

install:
	cpanm --installdeps --local-lib=./local .

test:
	PERL5LIB=local/lib/perl5 prove -l t

clean:
	rm -rf local

fetch:
	cd ../node-web-fetcher && npm run fetch

parse:
	PERL5LIB=local/lib/perl5 perl main.pl

all: clean install fetch parse
