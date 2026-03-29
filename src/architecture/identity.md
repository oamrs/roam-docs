# Identity And BYOI

ROAM follows a Bring Your Own Identity approach so teams can integrate with the identity systems they already trust instead of recreating users, roles, and organization structure from scratch.

## What BYOI Looks Like In Practice

With BYOI, ROAM aligns runtime behavior with your existing identity model by mapping external identity information into the public execution context.

That usually means carrying forward:

- organization or tenant boundaries
- user and service identity
- role or permission context
- capability or scope information that affects execution decisions

## Why This Matters

Identity-aware execution helps teams:

- keep ROAM aligned with existing access-control boundaries
- preserve organizational context across application and service calls
- reduce drift between product identity and runtime behavior
- support agent and automation workflows without inventing a parallel permission system

## Common Identity Sources

ROAM is well suited to identity models that originate from systems such as:

- enterprise directory providers
- source-control and collaboration platforms
- service-owned role and entitlement systems
- data-layer roles or scope definitions

The exact integration path can vary, but the goal stays the same: keep runtime decisions grounded in the identity model your organization already operates.

## Identity In The Execution Path

Identity becomes most useful when it arrives with the request itself. In practice, that means ROAM can use identity context to:

- interpret which organization or tenant owns the request
- understand which actor initiated the work
- choose the right runtime augmentation or policy path
- emit more meaningful, audit-safe runtime events

## Integration Guidance

The best BYOI integrations keep identity signals stable, explicit, and close to the request boundary.

Start by identifying:

- which system is the source of truth for identity
- which parts of that identity must influence runtime decisions
- which fields need to travel through the public ROAM headers or protocol surface

From there, use ROAM to preserve that context consistently across clients, services, and execution paths.
