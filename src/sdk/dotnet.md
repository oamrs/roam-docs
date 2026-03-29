# .NET SDK Guide

Use the `roam-dotnet` package when you want to integrate ROAM into .NET services, enterprise applications, and platform components with a typed client experience that fits naturally into the broader .NET ecosystem.

## Why Choose The .NET SDK

- Integrate ROAM into ASP.NET, worker services, and internal platform components.
- Build strongly typed service-to-service integrations on a familiar .NET foundation.
- Adopt ROAM in production applications without dropping to lower-level protocol work unless you need it.

## Installation

```bash
dotnet add package Roam.Dotnet
```

Or via NuGet:

```
Install-Package Roam.Dotnet
```

## What You Get

The .NET SDK gives you:

1. **A typed .NET integration surface** for embedding ROAM into application and platform code.
2. **Interop over the public runtime model** so .NET services stay aligned with the supported ROAM contract.
3. **Utilities and examples** that help teams wire ROAM into real service and enterprise deployment patterns.

## Quick Start

```csharp
using Roam;

var engine = new ReflectionEngine();
var server = new GrpcServer();

await server.RunAsync();
```

This is the fastest way to stand up a .NET integration, validate the client path, and start wiring ROAM into a service or application workflow.

## Runtime Augmentation

ROAM runtime calls can carry runtime-augmentation selection metadata so your .NET application can attach stable business and request context before validation or execution.

Use the public runtime headers when you need ROAM behavior to reflect application identity, tool intent, tenant boundaries, or domain-specific routing context.

The key runtime headers are:

- `x-roam-runtime-augmentation-id` to reference a specific augmentation identifier
- `x-roam-runtime-augmentation-key` to reference a stable augmentation key
- `x-roam-tool-name`, `x-roam-tool-intent`, `x-roam-user-id`, `x-roam-organization-id`, `x-roam-domain-tags`, and `x-roam-table-names` to provide matching context

ROAM emits resolved augmentation identity into normal query events, while sensitive rendered content remains reserved for dedicated audit handling.

## Suggested Starting Points

- Shipping a typed platform or product integration on .NET: start here.
- Embedding ROAM into an ASP.NET or worker-service architecture: start here.
- Passing application context into ROAM execution paths: start with the runtime-augmentation headers above.

## Contributing

### For Rust Core Changes

If you need to change the shared public runtime or core ROAM behavior:

1. File an issue in [roam-public](https://github.com/oamrs/roam-public)
2. Submit a PR to roam-public (see [Contribution Workflow](../contributing/workflow.md))
3. Once merged and exported, the change flows to roam-dotnet automatically

### For .NET Layer Improvements

To improve the .NET developer experience, add helpers, or expand documentation:

1. Fork roam-dotnet
2. Create a feature branch
3. Make changes in `Roam/` (.NET layer only)
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

See the [full API docs](./api.md) for the .NET package surface, method signatures, and integration details.
