# Contribution Workflow

## Overview

ROAM uses the private monorepo as the review boundary for open-core changes. Public repositories are downstream publication targets for approved changes in the relevant subtree paths.

## High-Level Flow

```text
Contributor or Maintainer
    ↓
1. Create branch from roam/main
2. Change code in private and/or public subtree paths
3. Add or update tests first
4. Open PR to roam/main
    ↓
GitHub Actions
    ↓
5. Run quality, coverage, docs, runtime, and security gates
    ↓
Maintainers
    ↓
6. Review architecture, complexity, and test quality
7. Merge to roam/main
    ↓
GitHub Actions
    ↓
8. Re-run validation checks on main
9. Publish only from explicit release tags
```

## Branch and PR Expectations

- Keep library and service changes small enough to review for responsibility boundaries.
- If a unit test requires several mocks or stubs, split the production code before adding more test scaffolding.
- If a test is named `integration`, it must talk to a started runtime over the network. If it does not, name it differently.

## Local Git Hooks

Enable the repo-managed hooks after cloning:

```bash
make hooks-install
```

This configures `core.hooksPath` to `.githooks` for the local clone.

The tracked pre-commit hook runs:

- `make quality-checks`
- `make test`

If either command fails, the commit is blocked before it is created.

## For External Contributors

### Step 1: Fork and Setup

```bash
# Fork roam-public on GitHub, then:
git clone https://github.com/<your-username>/roam-public.git
cd roam-public
git remote add upstream https://github.com/oamrs/roam-public.git
```

### Step 2: Create Feature Branch

Follow the naming convention: **`<number>-<description>`**

Examples:
- `13-the-mirror` (component)
- `14-orm-metadata-extraction` (feature)
- `15-gRPC-interceptor-hooks` (feature)

```bash
git checkout -b 13-the-mirror
```

### Step 3: Make Changes

Guidelines:

- Write tests first.
- Prefer Make targets over direct commands where available.
- Keep unit tests in-process and deterministic.
- Keep integration tests network-bound and runtime-backed.
- Update docs when the workflow or contract changes.

### Step 4: Submit PR

Push your branch and open a PR against `upstream/main`:

```bash
git push origin 13-the-mirror
```

**PR Template (include in description):**

```markdown
## Description
Brief summary of changes

## Related Issues
Fixes #123

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change

## Testing
Describe how you tested this

## Checklist
- [ ] Tests pass locally
- [ ] Code follows Rust conventions
- [ ] Documentation updated (if applicable)
```

### Step 5: CI Checks

When you open a PR, GitHub Actions runs the current quality profile, including:

- frontend lint and unit tests
- Rust formatting and clippy checks
- Rust coverage thresholds for key libraries and services
- runtime-backed test suites
- mdBook build
- dependency audit

All checks must pass before merge.

SDK-specific maintainability gates are opt-in. A new SDK does not automatically get a language-specific complexity gate; only SDKs with substantial handwritten logic should add one.

Release workflows are separate from CI. A merge to `main` validates the codebase, but public publication happens only from explicit release tags.

### Step 6: Code Review

A maintainer will:
1. Review your code for correctness and style
2. Ask questions if anything is unclear
3. Request changes if needed
4. Approve when ready

### Step 7: Merge to Main

Once approved, a maintainer merges to `roam/main`. That merge reruns validation on `main`, but does not publish public artifacts by itself.

When a release is intended:

1. Create a `public-v*` tag to publish public subtrees changed since the previous public release tag.
2. Create an `sdk-python-v*` tag to publish the Python SDK to PyPI.
3. Add language-specific SDK release workflows and tag patterns as additional SDKs are introduced.

If you need to release only a chosen subset of public targets, use the manual dispatch input on the public release workflow and provide explicit subtree prefixes.

Recommended SDK tag taxonomy:

- `sdk-python-v*`
- `sdk-typescript-v*`
- `sdk-rust-v*`
- `sdk-go-v*`

Use the general form `sdk-<language>-v*` for future SDK release workflows.

## For Maintainers

### Review Focus

Before merging to `main`:

1. Verify the code matches the declared test layer.
2. Verify that mock-heavy tests are not hiding multi-responsibility code.
3. Verify public subtrees do not contain private-service or credential material.
4. Verify docs reflect any workflow or contract change.

### Merge to Main

```bash
git checkout main
git merge --no-ff <feature-branch>
git push origin main
```

That push triggers validation only. Publication happens from release tags, not directly from the merge.

## Common Workflows

### "I found a bug in roam-python"

1. Determine whether the bug is in the Rust core or the Python layer.
2. Fix it in the corresponding subtree path inside this monorepo.
3. Release the updated SDK from the appropriate language-specific release workflow after review.

### "I want to add a Python helper function"

1. Don't fork roam-public (that's for Rust core)
2. Fork roam-python instead
3. Add your helper in the Python layer
4. Submit PR to roam-python/main
5. We'll review and merge

### "I want to contribute to roam-python but also need a roam-public fix"

1. First, submit the roam-public PR (follows External Contributor steps above)
2. Once that's merged and exported, start your roam-python PR
3. Or, fork both and coordinate in PRs

## Troubleshooting

### "My CI check failed"

Check the GitHub Actions log:
- Missing test coverage? Add tests
- Clippy warning? Fix the style issue
- Format error? Run `cargo fmt`

### "My branch is behind main"

Rebase and force-push:

```bash
git fetch upstream
git rebase upstream/main
git push origin <branch> --force
```

### "How do I know my change was exported?"

Watch the release workflow triggered by your `public-v*` or `sdk-python-v*` tag. A merge to `main` alone is not a release.
