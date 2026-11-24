---
name: roblox-code-review
description: "Reviews Aethermoor Roblox and Luau changes for project fit, server authority, Rojo placement, and test evidence."
---

# Roblox code review

Review the proposed diff without editing files unless the user asks for fixes.

## 1. Load project context

- Read AGENTS.md and the relevant parts of docs/DEVELOPMENT/DEVELOPMENT_PROTOCOL.md.
- Check README.md, docs/PROJECT_CHARTER.md, docs/DECISIONS.md, and the affected system contract.
- Inspect default.project.json and the current code/tests around each change.
- Separate approved behavior from proposals and unresolved decisions.

## 2. Check Roblox-specific risks

- Does every script/module map to the intended Roblox service and run context?
- Is server authority preserved for consequential state?
- Are all client requests validated for ownership, type, bounds, frequency, and context?
- Are shared modules free from server-only APIs and secrets?
- Are DataStore changes backed by an approved contract and safe load/session behavior?
- Are existing canonical IDs/configuration reused rather than duplicated?
- Are Roblox APIs verified against current official documentation when uncertain?

## 3. Check evidence

- Verify whether tests were actually run. Do not infer passing tests from a checklist or a workflow definition.
- Separate static/Luau checks, Rojo build, Studio Play Test, mock tests, and real multi-client validation.
- Report missing checks as not run; do not call them failures unless an execution failed.

## 4. Report

List actionable findings first, with severity and file/line references. Then summarize what looks sound, checks verified, and remaining limitations. Do not approve or merge a PR on behalf of the user.
