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

## GitHub Pages Deployment

The repo includes a dedicated workflow at `.github/workflows/cd-docs-pages.yml` that builds `services/roam-docs` and publishes the generated `book/` directory to GitHub Pages when a docs release tag matching `roam-docs-v*.*.*` is pushed, or by manual dispatch.

Recommended release flow:

```bash
git tag roam-docs-v0.1.0
git push origin roam-docs-v0.1.0
```

This keeps the Pages deployment tied to an explicit docs release instead of every merge to `main`.

To keep the site private to the `oamrs` organization, configure the repository in GitHub before the first run:

1. Open `Settings -> Pages` for the `oamrs/roam` repository.
2. Set `Source` to `GitHub Actions`.
3. Set the site visibility/access control to the private org-only option that your GitHub plan exposes.
4. If the organization restricts Pages usage, allow this repository under the organization Pages policy.

Once that is configured, the workflow will deploy the mdBook output without requiring a separate publishing branch.
