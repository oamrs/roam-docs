# Prompt Hooks

Prompt hooks let operators inject stable, reviewed prompt templates into runtime query execution without hard-coding prompt text in every client.

This page covers:

- how hooks are stored and managed
- how the runtime decides which hook to use
- what metadata clients should send
- what gets audited versus what stays out of generic events
- how to run the persisted-hook gRPC runtime locally

## What A Prompt Hook Is

A prompt hook is a persisted record that contains:

- a stable `id`
- a human-readable `name`
- an `enabled` flag
- a numeric `priority`
- an optional `selector_key`
- a `markdown_template`
- optional YAML `matching_rules_yaml`

At runtime, ROAM resolves at most one hook for a query. If the match is ambiguous at the highest priority, the runtime fails closed instead of guessing.

## Admin API

Prompt hooks are managed from the backend under `/api/prompt-hooks`.

Available routes:

- `GET /api/prompt-hooks`
- `GET /api/prompt-hooks/<id>`
- `POST /api/prompt-hooks`
- `PUT /api/prompt-hooks/<id>`
- `DELETE /api/prompt-hooks/<id>`
- `POST /api/prompt-hooks/preview`
- `POST /api/prompt-hooks/resolve`

The admin routes require either:

- `X-User-Role: admin`
- `X-User-Role: owner`
- or `X-User-Permissions` containing `manage:organization`

## Resolution Inputs

The runtime builds a `PromptHookResolveRequest` from query metadata and schema context.

Important request inputs:

- explicit hook id
- explicit selector key
- user id
- organization id
- tool name
- session id
- grants
- database identifier
- table names
- domain tags
- additional variables such as agent id, agent version, schema mode, and tool intent

Resolution order is intentional:

1. explicit hook selection wins when provided
2. otherwise selector and matching rules are evaluated
3. highest-priority matching hook is selected
4. ambiguous top-priority matches fail closed
5. if there is no explicit selection and nothing matches, the runtime may continue without a hook

## Runtime Headers

The gRPC runtime reads the following metadata headers from the request:

- `x-roam-session-id`
- `x-roam-user-id`
- `x-roam-organization-id`
- `x-roam-tool-name`
- `x-roam-tool-intent`
- `x-roam-grants`
- `x-roam-prompt-hook-id`
- `x-roam-prompt-selector-key`
- `x-roam-domain-tags`
- `x-roam-table-names`

Use these headers when you want hook resolution to reflect the user, organization, tool, and schema context of the request.

## Eventing And Audit Boundary

ROAM now separates operational metadata from sensitive rendered prompt content.

Generic query events may include:

- `resolved_prompt_hook_id`
- `resolved_prompt_hook_name`
- `resolved_prompt_hook_selection_reason`
- `resolved_prompt_hook_matched_ids`

Generic query events do not include the full rendered prompt.

The full rendered prompt is emitted only in the dedicated `PromptHookAuditRecorded` event, alongside:

- database identifier
- query text
- prompt hook id and name
- selection reason
- rendered prompt
- timestamp

This boundary matters because streamed query events are broadly useful for runtime inspection, while rendered prompt text belongs in an explicit audit surface with tighter access and retention controls.

## Managed gRPC Runtime

For persisted prompt-hook resolution, use the backend-owned managed gRPC process instead of the standalone public gRPC binary.

Local startup:

```bash
make grpc-start
```

That target runs `roam-managed-grpc`, which:

- loads the backend config using `ROAM_ENV`
- connects to the config database
- runs backend migrations
- creates the gRPC executor with `DatabasePromptHookResolver`
- binds to `ROAM_GRPC_ADDR` or `127.0.0.1:50051` by default
- uses `ROAM_DB_PATH` for the query database or a temp sqlite path by default

This is the correct runtime for local testing when hooks must resolve from backend persistence.

## Recommended Operator Workflow

1. Create or update prompt hooks through the admin API or frontend UI.
2. Use the preview endpoint to verify template rendering and matching behavior.
3. Start the managed gRPC runtime with `make grpc-start`.
4. Send runtime metadata headers from the client so matching has enough context.
5. Inspect normal query events for selected hook identity.
6. Inspect audit events when you need the rendered prompt text for traceability.

## Failure Modes To Expect

- invalid hook YAML or template variables return validation errors at create, update, or preview time
- ambiguous matches at the highest priority fail closed
- explicit hook ids that do not exist fail resolution
- database access problems in the managed resolver surface as prompt-hook resolution failures before execution

## Where To Go Next

- See [Middleware & Integration](./middleware.md) for the broader runtime pipeline.
- See [Python](../sdk/python.md) for SDK-facing runtime guidance.
- See [API Reference](../api-reference.md) for generated Rust API docs.