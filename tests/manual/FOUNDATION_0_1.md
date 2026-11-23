# Foundation 0.1 — Manual Acceptance Checklist

**Status:** Studio Play Test completed 2026-11-23; 10/10 automated Luau cases passed. GitHub Actions tests and Rojo build passed.

## Setup

The project was integrated into the saved Roblox Studio place Lua Etérea! (placeId 89394300657763). Source changes are also present in branch implementation/foundation-0.1. This validation used direct Studio DataModel integration; a local Rojo connection was not used.

## Server checks

- [x] Project opens and runs without Luau syntax/runtime errors in the recorded Play Test.
- [x] Server bootstrap runs.
- [x] Joining a player sets SessionInitialized = true.
- [x] Leaving resets SessionInitialized = false exactly once (isolated lifecycle test with simulated Players signals).
- [x] No DataStore or character persistence is attempted in this version.

## Client checks

- [x] Client bootstrap runs.
- [x] Shared configuration loads.
- [x] Map registry loads.
- [x] Registry count equals seven.
- [x] IDs 1 through 7 all exist.
- [x] Names match the official map registry exactly.
- [x] ID 8 is rejected.

## Lifecycle and automated checks

- [x] Repeated Start() keeps one pair of event listeners.
- [x] Startup enumeration/event race does not process the same player twice.
- [x] Each of multiple distinct simulated players is processed once.
- [x] Duplicate player removal is ignored; SessionInitialized is set false once.
- [x] Stop() disconnects listeners and restart reconnects them.
- [x] Studio UnitTest runner: 10 run, 10 passed, 0 failed.
- [x] GitHub Actions: Luau tests and Rojo build passed for the PR head commit.

The lifecycle cases use injected mock Players/signals. They do not claim a multi-client live-server test. The false-on-leave assertion is automated against the simulated removal event; a separate live multi-client disconnect scenario was not performed.

## Expected canonical map IDs

1. Arvandill
2. Sandquill
3. Starkrock
4. Western Glades
5. Dar'Hanok
6. Vornstead
7. West Land

## Execution record

- Date: 2026-11-23 (America/Fortaleza).
- Roblox Studio: 0.748.0.7481526.
- Place: Lua Etérea!, placeId 89394300657763.
- Studio output: server and client bootstraps completed; no runtime errors; runner summary: 10 run, 10 passed, 0 failed.
- Rojo: not used for Studio synchronization. The pinned Rojo build in GitHub Actions passed.
- GitHub Actions: Luau tests and Rojo build both completed successfully on the PR head at validation time.
- Place saved to Roblox Team Create as version 4. It was saved, not published.
- No DataStore calls were made.

**Result:** Foundation 0.1 is validated for the checks above. The PR remains open and in draft pending review; no merge or publication was performed.
