PACKER=packer:latest

all:
	@echo all

.PHONY: build
build:
	docker build --tag $(PACKER) .

.PHONY: shell-container
shell-container: build
	docker run --rm -it --name packer -v $(shell pwd)/..:/workdir $(PACKER) /bin/bash

.PHONY: package
package: build
	docker run --rm -it --name packer -v $(shell pwd)/..:/workdir $(PACKER) /workdir/packer/pack.sh