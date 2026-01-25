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

gen-api-docs:
	@echo "Generating Rust API Docs (Workspace)..."
	@cd ../.. && cargo doc --workspace --no-deps
	@echo "Generating Rust API Docs (Public SDK)..."
	@cd ../../libraries/roam-public && cargo doc --no-deps
	
	@# Copy generated docs to src directory
	@mkdir -p src/api/rust
	@# Workspace docs (Backend, Procedures)
	@cp -r ../../target/doc/* src/api/rust/
	@# SDK docs (OAM crate)
	@cp -r ../../libraries/roam-public/target/doc/* src/api/rust/
	
	@echo "Rust API Docs staged in src/api/rust/"

serve: install gen-api-docs
	mdbook serve --open

build: install gen-api-docs
	mdbook build

clean:
	rm -rf book/
