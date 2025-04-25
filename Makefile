.PHONY: install test lint clean fetch parse push login publish

VERSION := $(shell date +"%Y%m%d-%H%M")-$(shell git rev-parse --short HEAD)

# Docker settings
APP_NAME = parser-lambda
AWS_REGION = af-south-1
AWS_ACCOUNT_ID = 107335506223
ECR_REPO = $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(APP_NAME)

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
	PERL5LIB=local/lib/perl5 perl -Ilib main.pl

build:
	docker build -t $(APP_NAME):$(VERSION) .

tag:
	docker tag $(APP_NAME):$(VERSION) $(ECR_REPO):$(VERSION)

push: login
	docker push $(ECR_REPO):$(VERSION)

login:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com

publish: build tag push 
	@echo "Pubished version: $(VERSION)"
