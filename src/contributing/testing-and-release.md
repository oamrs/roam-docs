# Testing and Release Policy

## Why This Policy Exists

The open-core boundary is only safe if test names match what they actually validate and if public publication happens only after the monorepo review path completes.

## Test Layers

### Unit

- In-process only
- No containers
- No live RPC or HTTP calls
- Minimal mocking only

If unit tests need deep mock hierarchies, treat that as a refactoring signal. The production code likely needs narrower responsibilities.

### Integration

- Real network requests only
- Runtime must actually start
- Containerized dependencies are expected for databases, LDAP, and peer services
- No mocks or local-framework shortcut clients

Examples that do not qualify as integration tests:

- Rocket local client tests
- in-memory SQLite fallbacks used to simulate a shared service runtime
- direct function invocation across what should be a protocol boundary

### End-to-End

- Deploy to a non-production environment
- Exercise the deployed system from the outside
- Validate service wiring, secrets, networking, and rollout behavior

This repository does not yet have the non-production environment required to run E2E tests.

## CI Gates

Pull requests to `main` must pass:

1. Frontend lint, unit tests, and production build
2. Python radon complexity gate for the Python SDK
3. Rust quality checks, including clippy cognitive complexity enforcement
4. Rust coverage thresholds for key library and service paths
5. Runtime-backed test suites
6. mdBook build
7. Dependency audit

Complexity grades follow these bands:

- Frontend: ESLint `complexity` threshold `20`
- Rust: clippy `cognitive_complexity` threshold `10`
- Python radon grades:
	- `A`: 1-5
	- `B`: 6-10
	- `C`: 11-20
	- `D` and above fail the gate

## Local Pre-Commit Gate

This repository also ships a tracked Git pre-commit hook.

Enable it locally with:

```bash
make hooks-install
```

The hook runs the same top-level local gates expected before opening a PR:

1. `make quality-checks`
2. `make test`

This does not replace CI, but it catches failures before the commit is created.

## Merge and Public Publication

Public repos are not updated from an unmerged branch.

The release path is:

1. Merge reviewed code to `main`
2. Re-run the gated workflow on `main`
3. Detect which public subtree paths changed
4. Push only those changed subtrees

This keeps the private monorepo as the enforcement point for quality, security, and release discipline.