---
name: roblox-studio-validation
description: "Plans and records Roblox Studio validation for Aethermoor, separating Studio runtime evidence from unit and mock tests."
---

# Roblox Studio validation

Use this skill only when the task includes Roblox Studio validation and a Studio environment is available.

## Before the run

1. Read AGENTS.md, the relevant acceptance checklist, and the source under test.
2. Confirm the intended Studio place and whether changes are authorized there.
3. Identify whether the check requires Edit, Server, Client, or a Play Test.
4. Prefer isolated test data. Do not enable or call live DataStore paths for validation.
5. Record the Studio version/place identity when available.

## During the run

- Execute only the planned check.
- Do not publish.
- Do not claim real multi-client coverage from one simulated player or mocked signals.
- Capture relevant Output messages and errors.
- If a Studio modification or place save is outside the task's explicit authorization, stop before making it and ask the user.

## After the run

Record:
- checks performed and their exact results;
- Studio version and place context;
- Output errors/warnings relevant to the tested behavior;
- what was mocked, skipped, or not verified;
- whether the place was saved. State clearly that saving is not publishing.

Never report a Studio test as passed unless it was actually executed.
