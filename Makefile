.PHONY: install test clean fetch parse all

install:
	cpanm --installdeps --local-lib=./local .

test:
	prove -l t

clean:
	rm -rf local

fetch:
	cd ../node-web-fetcher && npm run fetch

parse:
	perl main.pl

all: clean install fetch parse
