# Python SDK Guide

Use the `roam-python` package when you want to integrate ROAM into Python applications, automation workflows, and service-side tooling without giving up a script-friendly developer experience.

## Why Choose The Python SDK

- Build Python services and internal tools that need direct access to ROAM capabilities.
- Add ROAM-backed workflow automation to notebooks, jobs, and lightweight application code.
- Move quickly with a familiar Python surface while staying aligned with the public ROAM contract.

## Installation

```bash
pip install roam-python
```

## What You Get

The Python SDK gives you:

1. **A Python-first client surface** for integrating ROAM into application and automation code.
2. **Typed bindings over the public runtime model** so Python code stays aligned with the supported ROAM contract.
3. **Utility helpers and examples** that make it easier to adopt ROAM in real product and workflow scenarios.

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

This is the fastest path when you want to stand up a Python-based integration, validate connectivity, and start building application logic around ROAM.

## Runtime Augmentation

ROAM runtime calls can carry runtime-augmentation selection metadata so your application can attach stable request context before validation or execution.

Use the public runtime headers when you need ROAM behavior to reflect product context such as the calling tool, organization, or domain.

The key runtime headers are:

- `x-roam-runtime-augmentation-id` to reference a specific augmentation identifier
- `x-roam-runtime-augmentation-key` to reference a stable augmentation key
- `x-roam-tool-name`, `x-roam-tool-intent`, `x-roam-user-id`, `x-roam-organization-id`, `x-roam-domain-tags`, and `x-roam-table-names` to provide matching context

ROAM emits resolved augmentation identity into normal query events, while sensitive rendered content remains reserved for dedicated audit handling.

## Suggested Starting Points

- Building automation, internal tools, or orchestration logic in Python: start here.
- Prototyping a ROAM integration before standardizing it across services: start here.
- Passing runtime context from application code into ROAM execution paths: start with the runtime-augmentation headers above.

## Contributing

### For Rust Core Changes

If you need to change the shared public runtime or core ROAM behavior:

1. File an issue in [roam-public](https://github.com/oamrs/roam-public)
2. Submit a PR to roam-public (see [Contribution Workflow](../contributing/workflow.md))
3. Once merged and exported, the change flows to roam-python automatically

### For Python Layer Improvements

To improve the Python experience, add helpers, or expand documentation:

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

See the [full API docs](./api.md) for the Python package surface, method signatures, and integration details.
