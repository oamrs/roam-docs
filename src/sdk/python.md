# Python SDK Guide

The `roam-python` package is the Python binding for the ROAM framework's Rust core.

## Installation

```bash
pip install roam-python
```

## Architecture

`roam-python` contains:

1. **Rust Core (Read-only)** — Exported from roam-public via git subtree
   - `mirror/` — Reflection system
   - `interceptor/` — Lifecycle hooks
   - `executor/` — gRPC server and coordination

2. **PyO3 Bindings** — Python wrappers around Rust code
   - Low-overhead C FFI integration
   - Pythonic API surface
   - Type hints for IDE support

3. **Python Utilities** — Pure Python helpers
   - Configuration management
   - Logging and tracing
   - Example patterns

## Quick Start

```python
from roam.mirror import ReflectionEngine
from roam.executor import GrpcServer

# Initialize reflection
engine = ReflectionEngine()

# Start server
server = GrpcServer()
server.run()
```

## Runtime Prompt Hooks

ROAM runtime calls can carry prompt-hook selection metadata so the executor can resolve a persisted prompt template before validation or execution.

The key runtime headers are:

- `x-roam-prompt-hook-id` to force a specific hook by id
- `x-roam-prompt-selector-key` to select hooks by a stable business key
- `x-roam-tool-name`, `x-roam-tool-intent`, `x-roam-user-id`, `x-roam-organization-id`, `x-roam-domain-tags`, and `x-roam-table-names` to provide matching context

The executor emits resolved hook identity into normal query events, but the rendered prompt itself is reserved for the dedicated audit event.

If you need a local runtime that resolves hooks from backend persistence instead of an in-memory/static resolver, start the managed gRPC binary:

```bash
make grpc-start
```

That target runs the backend-owned `roam-managed-grpc` process, which reads:

- `ROAM_GRPC_ADDR` for the bind address
- `ROAM_DB_PATH` for the query database path used by the executor
- `ROAM_ENV` for the backend config profile used to connect to the config database

## Contributing

### For Rust Core Changes

If you need to modify `mirror/`, `interceptor/`, or `executor/`:

1. File an issue in [roam-public](https://github.com/oamrs/roam-public)
2. Submit a PR to roam-public (see [Contribution Workflow](../contributing/workflow.md))
3. Once merged and exported, the change flows to roam-python automatically

### For Python Layer Improvements

To add helpers, improve bindings, or enhance documentation:

1. Fork roam-python
2. Create a feature branch
3. Make changes in `roam/` (Python layer only)
4. Submit PR to roam-python/main
5. We'll review and merge

Example:

```python
# Add a utility function
# roam/utils/config.py

def load_config_from_file(path: str) -> dict:
    """Load ROAM configuration from YAML file."""
    ...
```

## API Reference

See the [full API docs](./api.md) for method signatures and examples.
