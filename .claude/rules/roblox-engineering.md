# Roblox engineering rules — Aethermoor

These rules apply to Roblox project files and extend the repository's existing AGENTS.md and development protocol. If a generic engine framework convention conflicts with Aethermoor's documents, follow Aethermoor's source of truth.

## Project mapping

- default.project.json defines how source paths map to Roblox services and script types. Check it before moving or creating scripts.
- Keep server code under the mapped server services, shared modules in the mapped replicated shared folder, and client code under the mapped client locations.
- Do not add framework-specific directories such as Godot src/core or Unity Assets unless Aethermoor explicitly adopts them.

## Luau and runtime boundaries

- New Luau modules should use --!strict where practical and preserve the repository's type conventions.
- The server is authoritative for persistence, progression, rewards, inventory, economy, and other consequential state.
- Treat all client input as untrusted. Validate identity, ownership, types, ranges, request frequency, and current state at the server boundary.
- Avoid sending secrets or authoritative state to replicated containers.
- Keep shared modules free of server-only APIs.
- Use canonical shared definitions rather than duplicating configuration or map IDs.

## Persistent data

- Do not implement DataStore access, profile schemas, session locking, or migrations based only on a proposal.
- A future persistence implementation must follow an approved Aethermoor contract, protect data from failed loads and stale sessions, and be tested with isolated test data.
- Never claim persistence safety from mocked storage tests alone.

## Evidence

- A successful Lune run, a Rojo build, a Studio Play Test, and a live multi-client test are different evidence.
- State which one was run and do not generalize mock results into runtime guarantees.
- Use current official Roblox documentation for engine API behavior; mark unverified APIs as unverified.
