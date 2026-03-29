# Runtime Context

Runtime context is how ROAM keeps execution grounded in the real application state that surrounds a request. It gives clients and services a public way to attach stable metadata before validation and execution begin.

## Why Runtime Context Matters

Runtime context helps ROAM answer practical questions such as:

- which tool or product surface initiated this request
- which user or organization the request belongs to
- which domain tags or table scopes matter for this execution
- which runtime augmentation should be applied before downstream work continues

Without that context, a request may still be valid at the protocol level but incomplete from a product and governance perspective.

## Runtime Augmentation

Runtime augmentation is the public mechanism for selecting additional execution context before a request is evaluated.

Clients can use:

- `x-roam-runtime-augmentation-id` when they already know the specific augmentation identifier
- `x-roam-runtime-augmentation-key` when they want to reference a stable application-facing key

Additional headers help ROAM match the right augmentation and preserve the meaning of the request:

- `x-roam-tool-name`
- `x-roam-tool-intent`
- `x-roam-user-id`
- `x-roam-organization-id`
- `x-roam-domain-tags`
- `x-roam-table-names`

## What Clients Should Send

Send the smallest stable set of metadata that explains why the request exists and which business boundary it belongs to.

Good examples include:

- the name of the calling product surface or tool
- the user or service identity associated with the request
- the tenant or organization boundary
- domain tags that explain business meaning
- table or resource hints when the execution path depends on them

## What ROAM Emits

ROAM emits resolved augmentation identity into normal query and runtime events so downstream systems can observe which public context was selected.

Sensitive rendered content is intentionally separated from generic event metadata and reserved for dedicated audit handling.

## Integration Guidance

Use runtime context when you want ROAM behavior to stay aligned with application intent rather than just raw transport details.

Typical uses include:

- attaching product identity in a multi-surface application
- carrying organization context through service-to-service calls
- selecting augmentation rules for automation or assistant workflows
- keeping audit and observability signals consistent across clients
