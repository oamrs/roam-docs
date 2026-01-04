# Contribution Workflow

## Overview

ROAM uses a **public-first contribution model**. Community contributions target `roam-public` directly, which then flows through the private monorepo and exports to SDKs.

## High-Level Flow

```
You (External Contributor)
    ↓
1. Fork roam-public
2. Create feature branch (13-, 14-, 15-, etc.)
3. Write code + tests
4. Submit PR to roam-public/main
    ↓
ROAM Maintainers
    ↓
5. Review code
6. Run CI (tests, linting, clippy)
7. Approve & merge to roam-public/main
    ↓
8. (Maintainer) Pull into roam monorepo (branch 1-the-mirror)
9. (Maintainer) Review integrated changes
10. (Maintainer) Merge to roam/main
    ↓
GitHub Actions (Automated)
    ↓
11. Export roam-public/ → roam-python (PyPI)
12. Export roam-public/ → roam-dotnet (NuGet)
13. Sync version tags to all polyrepos
    ↓
Package Registries
    ↓
14. Python SDK: pip install roam-python
15. .NET SDK: nuget install Roam.Dotnet
```

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

Work on your feature in `roam-public/`:

```
roam-public/
├── mirror/
│   ├── src/
│   │   ├── lib.rs
│   │   └── reflection.rs
│   ├── tests/
│   ├── Cargo.toml
│   └── README.md
```

**Guidelines:**
- Write tests alongside your code (TDD)
- Run `cargo test` locally
- Run `cargo clippy` for linting
- Follow Rust naming conventions

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

When you open a PR, GitHub Actions runs:
- `cargo test` — unit and integration tests
- `cargo clippy` — linting
- `cargo fmt --check` — formatting validation

**All checks must pass before merge.**

### Step 6: Code Review

A maintainer will:
1. Review your code for correctness and style
2. Ask questions if anything is unclear
3. Request changes if needed
4. Approve when ready

### Step 7: Merge to Main

Once approved, a maintainer merges to `roam-public/main`. Your changes are now in the public repo!

## For ROAM Maintainers

### Importing to Monorepo

Once `roam-public/main` has your changes, import them:

```bash
# In roam monorepo, on branch 1-the-mirror
git subtree pull --prefix roam-public https://github.com/oamrs/roam-public.git main --squash
```

This creates a commit with the squashed history from roam-public/main.

### Review in Monorepo

Before merging to roam/main:
1. Verify code integrates with roam-enterprise/
2. Run full monorepo tests
3. Check that no proprietary code leaked into roam-public/
4. Approve changes

### Merge to Main

```bash
git checkout main
git merge --no-ff 1-the-mirror
git push origin main
```

This triggers the export workflow automatically.

### Tagging for Release

When you're ready to release:

```bash
git tag v0.1.0 -m "First public release: The Mirror"
git push origin v0.1.0
```

The `sync-version-tags` job will:
1. Push tag to roam-python
2. Push tag to roam-dotnet
3. (Optional) Trigger package builds on registries

## Common Workflows

### "I found a bug in roam-python"

1. File an issue in roam-public: https://github.com/oamrs/roam-public/issues
2. Include reproduction steps
3. If it's Rust core code, we'll fix it in roam-public
4. If it's Python binding, we'll fix it in roam-python
5. Core fixes flow to roam-python on next export

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

Watch for a workflow run after we merge to roam/main. Check:
1. https://github.com/oamrs/roam-python/commits/main (new commit hash)
2. https://github.com/oamrs/roam-dotnet/commits/main (new commit hash)

Both should have your commit within 5 minutes.
