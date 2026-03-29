# Testing and Release Policy

ROAM treats testing and release discipline as part of the public contract. The goal is not just to ship code that works, but to ship public surfaces that are validated, predictable, and safe to adopt.

## Test Layers

### Unit Tests

Unit tests should stay fast, deterministic, and in-process.

Expectations:

- no live RPC or HTTP calls
- no containers
- minimal mocking only

If a unit test needs a large mock hierarchy, treat that as a signal to simplify the production code.

### Integration Tests

Integration tests should validate real boundaries.

Expectations:

- real network requests
- a runtime that actually starts
- real dependencies where the boundary matters
- no shortcut local clients standing in for protocol behavior

### End-To-End Tests

End-to-end tests validate a deployed environment from the outside. They are the right fit for rollout, wiring, secret, and networking concerns when that environment exists.

## CI Expectations

Pull requests to `main` should pass the quality profile relevant to the repository being changed. That can include:

- linting and formatting
- unit and integration tests
- build validation
- documentation builds
- coverage or maintainability gates where they add real signal
- dependency and security checks

SDK-specific maintainability gates are intentionally selective. They should exist where a codebase contains enough handwritten logic to justify them, not just because a language binding exists.

## Local Validation

When available, enable the repo-managed hooks locally:

```bash
make hooks-install
```

The local hook path is intended to catch common failures before you open a pull request. It complements CI, but does not replace it.

## Release Discipline

Validation and publication are separate steps.

The expected release path is:

1. merge reviewed code to `main`
2. allow validation to complete on the merged revision
3. create the appropriate release tag when publication is intended

Current public release patterns include:

- `public-v*` for public subtree publication
- `sdk-python-v*` for Python SDK publication
- `sdk-<language>-v*` as the general form for future SDK release workflows

## Why This Separation Exists

Separating merge validation from publication keeps the public ROAM surface more predictable for adopters.

It ensures that:

- every published artifact passed review first
- release timing is deliberate rather than accidental
- public packages and docs stay aligned with validated source
- teams can reason about adoption risk more clearly