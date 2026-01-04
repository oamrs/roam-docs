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
