.PHONY: validate configure build clean

validate:
	./scripts/validate.sh

configure:
	cd build && ./auto/config

build:
	sudo ./scripts/build-iso.sh

clean:
	cd build && sudo ./auto/clean

