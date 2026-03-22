# ROAM Docs

This directory contains the public mdBook documentation subtree for ROAM.

## Build

Preferred commands:

```bash
make -C services/roam-docs build
make -C services/roam-docs serve
```

If you need the raw tools directly:

```bash
cargo install mdbook mdbook-mermaid
mdbook build
```

The static output is written to `book/`.

## What This Book Covers

- Architecture and system boundaries
- Contributor workflow
- Test taxonomy and quality policy
- SDK-facing guidance

## Publication Model

`services/roam-docs` is a public subtree. It is pushed out from the monorepo only after changes merge to `main` and the post-merge gates pass.
