# Contribution Workflow

ROAM accepts contributions across the public runtime, SDKs, and documentation. The goal of the workflow is simple: keep the public contract stable, keep changes reviewable, and make it clear where each kind of contribution belongs.

## Choose The Right Repository

Start in the repository that owns the surface you want to improve.

- Use `roam-public` for shared runtime behavior, public contract changes, and core Rust functionality.
- Use `roam-python` for Python-specific helpers, bindings, packaging, and docs.
- Use `roam-dotnet` for .NET-specific helpers, bindings, packaging, and docs.

## Contribution Flow

1. Fork the repository that matches your change.
2. Create a small, clearly named branch.
3. Add or update tests with the change.
4. Update documentation when the public workflow or contract changes.
5. Open a pull request against `main`.
6. Address review feedback and keep the branch current until merge.

## Branch And PR Expectations

- Keep each change focused enough to review in one pass.
- Prefer small pull requests over large mixed-scope changes.
- If a unit test needs excessive mocking, simplify the production code before adding more scaffolding.
- If a test is called `integration`, it should talk to a real started runtime over the network.

## Local Validation

Enable the repo-managed hooks after cloning when they are available:

```bash
make hooks-install
```

The local pre-commit path is intended to catch quality and test failures before you open a pull request.

## External Contributor Setup

### Step 1: Fork And Clone

Example for `roam-public`:

```bash
git clone https://github.com/<your-username>/roam-public.git
cd roam-public
git remote add upstream https://github.com/oamrs/roam-public.git
```

### Step 2: Create A Branch

Use a descriptive branch name that matches the change you are making.

```bash
git checkout -b improve-runtime-context-docs
```

### Step 3: Make The Change

Guidelines:

- write tests alongside behavior changes
- prefer repo Make targets where they exist
- keep unit tests deterministic and in-process
- keep integration tests runtime-backed and network-bound
- update docs when the public contract or contribution workflow changes

### Step 4: Open A Pull Request

Push your branch and open a PR against `upstream/main`:

```bash
git push origin improve-runtime-context-docs
```

Include:

- a short description of the change
- the problem being solved
- how you validated the change
- any public contract impact or compatibility notes

## Review Standards

ROAM reviews focus on a few practical questions:

- does the change belong in this repository
- does the implementation stay within the intended public boundary
- do the tests match the behavior being claimed
- does the documentation still describe the public surface accurately

## Common Paths

### Fixing A Core Runtime Issue

Start with `roam-public` if the change affects shared runtime behavior, protocol shape, or public Rust functionality.

### Improving A Python Integration

Start with `roam-python` if the change is specific to the Python developer experience, helper layer, or packaging surface.

### Improving A .NET Integration

Start with `roam-dotnet` if the change is specific to the .NET developer experience, helper layer, or packaging surface.

## Release Expectations

Pull requests validate changes. Releases publish them.

If you need publication timing or release behavior details, continue with [Testing and Release Policy](./testing-and-release.md).
