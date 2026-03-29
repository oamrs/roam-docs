# API Reference

Use this page to choose the fastest way to integrate ROAM into your product. Whether you are embedding ROAM into an application, automating workflows, or standardizing service-to-service communication, the references below point to the public surfaces intended for real adoption.

## Client SDKs

Choose the SDK that best matches your application stack.

<div style="margin: 1rem 0; padding: 1rem; background-color: var(--quote-bg); border-left: 4px solid var(--links);">
    <a href="api/python/index.html" style="font-weight: bold; font-size: 1.1rem; text-decoration: none;">
        🐍 Python SDK
    </a>
    <p style="margin-top: 0.5rem; margin-bottom: 0;">
        Build Python applications and automation flows that integrate ROAM with a lightweight, script-friendly client surface.
    </p>
</div>

<div style="margin: 1rem 0; padding: 1rem; background-color: var(--quote-bg); border-left: 4px solid var(--links);">
    <a href="api/dotnet/index.html" style="font-weight: bold; font-size: 1.1rem; text-decoration: none;">
        🔷 .NET SDK
    </a>
    <p style="margin-top: 0.5rem; margin-bottom: 0;">
        Integrate ROAM into .NET services and enterprise applications with a familiar typed client experience.
    </p>
</div>

<div style="margin: 1rem 0; padding: 1rem; background-color: var(--quote-bg); border-left: 4px solid var(--links);">
    <a href="api/rust/oam/index.html" style="font-weight: bold; font-size: 1.1rem; text-decoration: none;">
        📦 OAM Client SDK (Rust)
    </a>
    <p style="margin-top: 0.5rem; margin-bottom: 0;">
        Use the core Rust crate when you want maximum control, native performance, or direct access to the public runtime model.
    </p>
</div>

## Shared Contract

When you need a language-neutral integration surface, start with the protocol definitions.

## Protobuf Definitions

<div style="margin: 1rem 0; padding: 1rem; background-color: var(--quote-bg); border-left: 4px solid var(--sidebar-fg);">
    <a href="api/rust/roam_proto/index.html" style="font-weight: bold; font-size: 1.1rem; text-decoration: none;">
        🔌 Roam Proto
    </a>
    <p style="margin-top: 0.5rem; margin-bottom: 0;">
        Review the public gRPC contract, message shapes, and service definitions that keep multi-language integrations aligned.
    </p>
</div>

## Suggested Starting Points

- Building application logic in Python: start with the Python SDK.
- Shipping a service or platform integration on .NET: start with the .NET SDK.
- Building custom runtimes or native integrations: start with the Rust client crate.
- Aligning multiple clients or generating your own bindings: start with the protobuf definitions.
