# Architecture Overview

## System Design

ROAM follows a **distributed public/private model** with a clear separation between community-facing and proprietary components.

### Four Repository Model

```
┌─────────────────────────────────────────────────────────────────┐
│                    oamrs GitHub Organization                    │
└─────────────────────────────────────────────────────────────────┘
                                │
                ┌───────────────┼───────────────┐
                ▼               ▼               ▼
        ┌────────────────┐  ┌──────────────┐  ┌──────────────┐
        │ roam-public    │  │ roam-python  │  │ roam-dotnet  │
        │   (PUBLIC)     │  │  (PUBLIC)    │  │  (PUBLIC)    │
        │                │  │              │  │              │
        │ mirror/        │  │ Rust bindings│  │ C# bindings  │
        │ interceptor/   │  │ PyO3 layer   │  │ C interop    │
        │ executor/      │  │ Utilities    │  │ Utilities    │
        └────────┬───────┘  └──────────────┘  └──────────────┘
                 │                ▲                   ▲
                 │ subtree import  │ subtree export   │
                 │                 │ (on main push)   │
                 ▼                 │                  │
        ┌────────────────────────────────────────────────────┐
        │         roam (PRIVATE MONOREPO)                    │
        │                                                    │
        │  ┌──────────────────────────────────────────────┐  │
        │  │  roam-public/  (imported from public repo)   │  │
        │  │  - mirror/                                   │  │
        │  │  - interceptor/                              │  │
        │  │  - executor/                                 │  │
        │  └──────────────────────────────────────────────┘  │
        │                                                    │
        │  ┌──────────────────────────────────────────────┐  │
        │  │  roam-enterprise/  (PROPRIETARY - NOT EXPORTED) │
        │  │  - billing/        (AAU telemetry)           │  │
        │  │  - policy-engine/  (Advanced P2SQL)          │  │
        │  │  - rbac/           (SSO, Row-level security) │  │
        │  └──────────────────────────────────────────────┘  │
        │                                                    │
        │  roam-hardware/, roam-proto/, etc.                 │
        └────────────────────────────────────────────────────┘
```

### Key Principles

1. **Public/Private Separation**
   - `roam-public` is the source of truth for community contributions
   - `roam` monorepo keeps proprietary `roam-enterprise` safe
   - Polyrepos (roam-python, roam-dotnet) receive only public exports

2. **Single Source of Truth**
   - Core logic lives in `roam-public`
   - Monorepo imports from public via subtree
   - SDKs receive read-only exports

3. **Community-First Design**
   - External contributors PR against `roam-public`
   - No need to understand the monorepo
   - Clear contribution path: issue → PR → merge → auto-export

## Component Details

### roam-public (Community Core)

**Public Rust components:**
- `mirror/` - SeaORM entity-to-tool reflection system
- `interceptor/` - ActiveModelBehavior hooks for lifecycle events
- `executor/` - Tonic/gRPC server with Tokio JoinSet coordination

**Why separate?** External contributors can fork, modify, and PR without monorepo access. Security boundary is clear.

### roam-enterprise (Proprietary Only)

**Never exported or open-sourced:**
- `billing/` - Advanced accounting with AAU (Active Agent Unit) telemetry
- `policy-engine/` - Semantic P2SQL (Property-to-SQL) analysis
- `rbac/` - Enterprise SSO and row-level security

**Why kept private?** Customer-facing features, licensing logic, and security modules.

### roam-python, roam-dotnet (SDKs)

**Contains:**
- Exported Rust core (read-only, synced via git subtree)
- Language-specific bindings (PyO3 for Python, C interop for .NET)
- SDK utilities and helpers (open to contribution)
- Examples and documentation

**External contributors can:**
- Improve language-specific wrappers
- Add utilities and helpers
- Fix SDK-layer bugs
- Enhance documentation

**External contributors cannot:**
- Modify exported Rust core (roam-public code)
- They must file issues/PRs in roam-public for core changes
