# Introduction

Welcome to the ROAM (Real-time Object Agent Mapping) Framework documentation.

ROAM is a distributed, modular system for semantic object mapping and agent coordination. This documentation covers:

- **Architecture** - System design, component relationships, and data flow
- **Prompt Hooks** - Prompt template selection, persistence, and audit behavior at runtime
- **Contributing** - Workflow for contributing to roam-public, PR process, and community guidelines
- **SDK Guides** - Language-specific bindings for Python and .NET

## Core Operational Modes

ROAM integrates into your infrastructure in two distinct ways:

*   **Active Mode (User-Driven)**: The End User initiates actions via your UI/API. OAM intercepts these requests to validate identity and policy, asynchronously notifying the Agent (Shadow Mode).
*   **Passive Mode (Assistant)**: The Agent observes existing event streams (Kafka, gRPC). If authorized by BYOI, it assists or validates the flow without blocking normal operations.

## Quick Links

- **roam-public** - [Community contributions](https://github.com/oamrs/roam-public)
- **roam-python** - [Python SDK](https://github.com/oamrs/roam-python)
- **roam-dotnet** - [.NET SDK](https://github.com/oamrs/roam-dotnet)
- **roam** - [Private monorepo](https://github.com/oamrs/roam) (team access only)

## Getting Started

1. Start with [Architecture Overview](./architecture/overview.md)
2. Read [Prompt Hooks](./architecture/prompt-hooks.md) if you need prompt selection, admin APIs, or runtime hook metadata
3. Read [Contribution Workflow](./contributing/workflow.md)
4. Choose your SDK: [Python](./sdk/python.md) or [.NET](./sdk/dotnet.md)
