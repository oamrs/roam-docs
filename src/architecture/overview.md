# Architecture Overview

ROAM is designed as a public runtime layer that sits close to execution boundaries. It helps products and services carry identity, policy, and agent-aware context through application logic without forcing teams to redesign the rest of their stack.

## Public Runtime At A Glance

The public ROAM surface is organized around three adoption layers:

1. **Core runtime** for shared execution, reflection, and protocol behavior.
2. **Language SDKs** for integrating ROAM into Python and .NET applications.
3. **Shared protocol definitions** for teams that need language-neutral contracts or generated bindings.

## Public Building Blocks

### Runtime Model

The runtime model gives ROAM a consistent way to:

- interpret structured requests and tool-facing operations
- apply identity and organization context to execution
- attach runtime augmentation metadata before validation and execution
- emit audit-safe events and observable outcomes

### SDK Layer

The Python and .NET SDKs package that runtime model into language-specific integration surfaces. They are the fastest path for teams that want to add ROAM to existing products, services, and automation workflows.

### Shared Contract

When teams need multi-language interoperability, generated clients, or direct protocol-level integration, the shared protobuf and gRPC contract provides the stable public boundary.

## Where ROAM Fits In The Stack

ROAM usually appears in one of these roles:

- **Request-path integration** where a service or API validates and enriches execution context before work continues.
- **Runtime coordination** where a client or middleware layer passes identity, tool, and organization context into downstream execution.
- **Event-driven integration** where ROAM participates in decisions triggered by messages, jobs, or automation pipelines.

## Adoption Paths

### Start With An SDK

Use an SDK when you want to move quickly inside an application stack. This is the best fit for:

- service teams integrating ROAM into existing APIs
- platform teams standardizing runtime context across applications
- automation teams building product or operations workflows

### Start With The Shared Contract

Use the protocol definitions when you want to:

- generate your own client bindings
- align multiple services around one public contract
- integrate from a language or platform that does not yet have a first-party SDK

## Operating Modes

ROAM supports both user-driven and event-driven execution patterns.

### Application-Driven Mode

In application-driven flows, a user or upstream service initiates the request. ROAM enriches or validates that request as it moves through an application or API boundary.

### Event-Driven Mode

In event-driven flows, ROAM participates when a message, RPC call, or background job creates a decision point that needs shared runtime context or policy-aware behavior.
