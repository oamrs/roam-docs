# Introduction

ROAM is a runtime integration framework for products and services that need consistent identity-aware execution, policy enforcement, and agent-ready context across application boundaries.

This documentation is organized to help you evaluate, integrate, and extend the public ROAM surface with minimal friction.

## What This Book Covers

- **Architecture** explains how ROAM fits into application, service, and event-driven systems.
- **Runtime Context** explains how request metadata and runtime augmentation travel with execution.
- **Contributing** explains how to propose changes to the public runtime, SDKs, and documentation.
- **SDK Guides** help you choose the best starting point for Python and .NET integrations.

## Where ROAM Fits

ROAM is designed for teams that want to:

- add policy-aware execution to application and service workflows
- carry stable identity and organization context through runtime operations
- integrate agent-driven or automation-driven behavior without rewriting existing systems
- standardize public integration contracts across multiple languages

## Operating Patterns

ROAM typically appears in one of two patterns:

- **Application-intercepted flows** where ROAM validates and enriches requests as they move through an API or service boundary.
- **Event-driven flows** where ROAM observes or participates in runtime decisions driven by messages, RPC calls, or automation pipelines.

## Quick Links

- [roam-public](https://github.com/oamrs/roam-public) for the public Rust core and shared runtime contract
- [roam-python](https://github.com/oamrs/roam-python) for Python integrations and automation workflows
- [roam-dotnet](https://github.com/oamrs/roam-dotnet) for .NET services and typed enterprise integrations

## Suggested Starting Path

1. Start with [Architecture Overview](./architecture/overview.md) to understand the public runtime model.
2. Read [Runtime Context](./architecture/runtime-context.md) if you need request metadata and runtime-augmentation guidance.
3. Choose your SDK: [Python](./sdk/python.md) or [.NET](./sdk/dotnet.md).
4. Use [API Reference](./api-reference.md) when you are ready for package and protocol details.
