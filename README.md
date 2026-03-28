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

The monorepo uses the shared public release workflow at `.github/workflows/cd-public.yml` to publish public subtrees from `main`.

Recommended release flow:

```bash
git tag roam-docs-v0.1.0
git push origin roam-docs-v0.1.0
```

This keeps public docs publication tied to an explicit docs release instead of every merge to `main`.

The shared workflow supports both release styles:

- `public-v*` publishes only the public subtrees that changed since the previous `public-v*` tag
- `roam-docs-v*` always publishes `services/roam-docs`

Any tracked content change inside `services/roam-docs` is enough to trigger the next docs-only release publish.

The workflow uses `main` as the source of truth for subtree publication, so the docs changes you want published must already be merged there before the tag is created.

For authentication, the preferred setup is a single organization-level Actions secret named `SUBTREE_PUSH_TOKEN` owned by a machine user or GitHub App that has write access only to the public subtree target repositories. The workflow still supports `SUBTREE_SSH_KEY` as a fallback for older deployments.

After the subtree is pushed, GitHub Pages should be enabled in the public `oamrs/roam-docs` repository:

1. Open `Settings -> Pages` for the `oamrs/roam-docs` repository.
2. Set `Source` to `GitHub Actions`.
3. Leave `Custom domain` empty unless you plan to serve docs from your own DNS name.
4. The subtree already includes `.github/workflows/pages.yml`, which installs `mdbook` and `mdbook-mermaid`, builds the site from `src/`, and publishes the generated `book/` directory when the public repo updates.

Once that is configured, a `roam-docs-v*` release tag in the monorepo will push the latest docs subtree from `main` to `oamrs/roam-docs`, and the public repo can publish the updated site.
