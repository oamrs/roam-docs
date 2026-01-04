# .NET SDK Guide

The `roam-dotnet` package is the C# binding for the ROAM framework's Rust core.

## Installation

```bash
dotnet add package Roam.Dotnet
```

Or via NuGet:

```
Install-Package Roam.Dotnet
```

## Architecture

`roam-dotnet` contains:

1. **Rust Core (Read-only)** — Exported from roam-public via git subtree
   - `mirror/` — Reflection system
   - `interceptor/` — Lifecycle hooks
   - `executor/` — gRPC server and coordination

2. **C# Interop Layer** — C bindings and marshaling
   - P/Invoke for native Rust functions
   - Safe wrapper types
   - Async/await support

3. **.NET Utilities** — Pure C# helpers
   - Dependency injection integration
   - Configuration providers
   - Example projects

## Quick Start

```csharp
using Roam;

var engine = new ReflectionEngine();
var server = new GrpcServer();

await server.RunAsync();
```

## Contributing

### For Rust Core Changes

If you need to modify `mirror/`, `interceptor/`, or `executor/`:

1. File an issue in [roam-public](https://github.com/oamrs/roam-public)
2. Submit a PR to roam-public (see [Contribution Workflow](../contributing/workflow.md))
3. Once merged and exported, the change flows to roam-dotnet automatically

### For C# Layer Improvements

To add helpers, improve interop, or enhance documentation:

1. Fork roam-dotnet
2. Create a feature branch
3. Make changes in `Roam/` (C# layer only)
4. Submit PR to roam-dotnet/main
5. We'll review and merge

Example:

```csharp
// Add a utility class
// Roam/Config/ConfigLoader.cs

public static class ConfigLoader
{
    public static RoamConfig LoadFromFile(string path)
    {
        // Load configuration
    }
}
```

## API Reference

See the [full API docs](./api.md) for method signatures and examples.
