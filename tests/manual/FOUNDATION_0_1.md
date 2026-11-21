# Foundation 0.1 — Manual Acceptance Checklist

**Status:** Test procedure documented; execution pending in Roblox Studio.

## Setup

1. Install Roblox Studio.
2. Install Rojo and the VS Code extension, or use the Rojo CLI.
3. Open the repository root.
4. Run `rojo serve default.project.json`.
5. Connect Roblox Studio to the Rojo server.

## Server checks

- [ ] Project opens without Luau syntax errors.
- [ ] Server bootstrap runs once.
- [ ] Joining a player sets `SessionInitialized = true`.
- [ ] Leaving a player sets `SessionInitialized = false`.
- [ ] No DataStore or character persistence is attempted in this version.

## Client checks

- [ ] Client bootstrap runs.
- [ ] Shared configuration loads.
- [ ] Map registry loads.
- [ ] Registry count equals seven.
- [ ] IDs 1 through 7 all exist.
- [ ] Names match the official map registry exactly.

## Expected canonical map IDs

1. Arvandill
2. Sandquill
3. Starkrock
4. Western Glades
5. Dar'Hanok
6. Vornstead
7. West Land

## Exit criteria

Foundation 0.1 can be marked **TESTED** only after the checklist is executed in Roblox Studio and the result, Studio version, Rojo version (if used), and any output/errors are recorded. Until then, status remains **IMPLEMENTED — TEST PENDING**.
