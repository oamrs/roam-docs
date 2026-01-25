.PHONY: help build serve clean install

help:
	@echo "ROAM Documentation Build System"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install    Install mdbook (if not already installed)"
	@echo "  build      Build static HTML documentation"
	@echo "  serve      Start development server at http://localhost:3000"
	@echo "  clean      Remove build artifacts"
	@echo "  help       Show this help message"

install:
	@command -v mdbook >/dev/null 2>&1 || cargo install mdbook
	@command -v mdbook-mermaid >/dev/null 2>&1 || cargo install mdbook-mermaid
	@mdbook-mermaid install .
	@echo "mdbook tooling is ready"

serve: install
	mdbook serve --open

build: install
	mdbook build

clean:
	rm -rf book/
