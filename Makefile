.PHONY: help build serve clean install gen-api-docs serve-headless

CARGO_BIN := $(HOME)/.cargo/bin
export PATH := $(CARGO_BIN):$(PATH)

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
	@$(CARGO_BIN)/mdbook-mermaid install . || true
	@echo "mdbook tooling is ready"

gen-api-docs:
	@echo "Generating Rust API Docs (Public SDK)..."
	@cd ../../libraries/roam-public && cargo doc --no-deps
	@echo "Generating Rust API Docs (Proto crate)..."
	@cd ../../libraries/roam-proto && cargo doc --no-deps
	@# Copy generated docs to src directory
	@rm -rf src/api/rust
	@mkdir -p src/api/rust
	@# SDK docs (OAM crate)
	@cp -r ../../libraries/roam-public/target/doc/* src/api/rust/
	@# Public proto docs
	@cp -r ../../target/doc/roam_proto src/api/rust/
	@python3 -c 'import json; from pathlib import Path; root = Path("src/api/rust"); crates = sorted(path.name for path in root.iterdir() if path.is_dir() and (path / "index.html").exists()); (root / "crates.js").write_text("window.ALL_CRATES = " + json.dumps(crates) + ";\\n", encoding="utf-8")'
	@# Staging Python/DotNet Placeholders (Real generation requires pdoc/docfx)
	@mkdir -p src/api/python
	@echo "<html><body><h1>Python SDK Docs Coming Soon</h1></body></html>" > src/api/python/index.html
	@mkdir -p src/api/dotnet
	@echo "<html><body><h1>.NET SDK Docs Coming Soon</h1></body></html>" > src/api/dotnet/index.html
	@echo "Rust API Docs staged in src/api/rust/"

serve: install gen-api-docs
	PATH=$(CARGO_BIN):$$PATH $(CARGO_BIN)/mdbook serve --open

serve-headless: install gen-api-docs
	PATH=$(CARGO_BIN):$$PATH $(CARGO_BIN)/mdbook serve -n 0.0.0.0

build: install gen-api-docs
	PATH=$(CARGO_BIN):$$PATH $(CARGO_BIN)/mdbook build

clean:
	rm -rf book/