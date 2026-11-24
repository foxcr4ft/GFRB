# Aethermoor — Claude Code guidance

@AGENTS.md

## Roblox project profile

- Engine: Roblox Studio.
- Language: Luau.
- Project mapping: Rojo, configured in default.project.json.
- Runtime boundaries: server-owned gameplay and persistence; clients provide presentation and submit validated requests.
- Project rules and approved decisions live in the existing Aethermoor documentation. Do not replace them with generic framework defaults.

Before implementation, follow the repository instructions in AGENTS.md and docs/DEVELOPMENT/DEVELOPMENT_PROTOCOL.md. Read the relevant approved design documents and inspect the current branch.

## Roblox-specific constraints

- Use Roblox/Luau patterns. Do not assume Godot, Unity, Unreal, Phaser, or web-engine APIs or directory layouts.
- Treat client input and RemoteEvent/RemoteFunction payloads as untrusted. Validate ownership, types, bounds, frequency, and context on the server.
- Do not introduce DataStore code, a persistent schema, or migrations until an approved Aethermoor persistence contract exists. Proposals remain proposals.
- Preserve the canonical map IDs and use the shared MapRegistry; do not duplicate IDs in gameplay code.
- Verify engine APIs against current official Roblox documentation when correctness depends on API details.
- Keep Studio validation distinct from Lune/unit tests and mocked tests. Record exactly which environment ran.

## Tooling

The repository already has a Luau test runner and a GitHub Actions workflow for Luau tests and a Rojo build. Inspect and reuse those before proposing new tools or CI jobs.

Do not enable or copy upstream Claude Code settings and hooks automatically. Any hook or command integration must be reviewed for file writes, network access, and Git side effects first. Never publish a Roblox experience or merge a pull request without the user's explicit instruction.
