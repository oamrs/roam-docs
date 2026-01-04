.PHONY: help build serve clean install

help:
	@echo "ROAM Documentation Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  make install    Install mdBook (one-time setup)"
	@echo "  make serve      Start local server at http://localhost:3000"
	@echo "  make build      Build static site to ./book/"
	@echo "  make clean      Remove built site"
	@echo "  make help       Show this message"

install:
	cargo install mdbook

serve:
	mdbook serve --open

build:
	mdbook build

clean:
	rm -rf book/
