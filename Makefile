.PHONY: install clean fetch parse all

install:
	cpanm --installdeps --local-lib=./local .

clean:
	rm -rf local

fetch:
	cd ../node-web-fetcher && npm run fetch

parse:
	perl main.pl

all: clean install fetch parse
