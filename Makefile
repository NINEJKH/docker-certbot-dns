SHELL := bash

DOCKER_REPO ?= certbot-dns


.PHONY: all
all:


.PHONY: build
build:
	docker build \
		--pull \
		-t '$(DOCKER_REPO):latest' \
		.


.PHONY: test
test:
	docker run --rm '$(DOCKER_REPO):latest' --version


.PHONY: publish
publish:
	echo '$(DOCKER_PASSWORD)' | docker login --username '$(DOCKER_USERNAME)' --password-stdin
	docker push '$(DOCKER_REPO):latest'
