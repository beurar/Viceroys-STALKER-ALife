# Copilot instructions — Viceroy's STALKER ALife

Short guide to help an AI coding agent be productive in this codebase.

1) Quick orientation
- This repo is an Arma 3 addon (folder: `addons/Viceroys-STALKER-ALife`) implementing a modular ALife system (anomalies, mutants, storms, minefields, etc.). See [README.md](README.md) for system-level descriptions.
- Primary runtime pieces: `initServer.sqf` (server-side startup), `functions/` (SQF function library), `cba_settings.sqf` (CBA settings), and `config.cpp`/`mod.cpp` (engine integration).

2) Big-picture architecture
- Systems are organized by folder under `functions/` (core, anomalies, mutants, chemical, spooks, minefields, etc.). Each folder exposes `fn_*.sqf` scripts mapped in `config.cpp` via `CfgFunctions`.
- `initServer.sqf` (addons/Viceroys-STALKER-ALife/initServer.sqf) and `fn_masterInit.sqf` are the runtime entry points; many managers spawn and sleep based on the CBA setting `VSA_playerNearbyRange`.
- Persistent runtime state is kept in global arrays (e.g. `STALKER_anomalyFields`, `STALKER_activeHerds`) initialized in `initServer.sqf`.

3) Key integration and IPC patterns
- Remote-exec and RPC: `CfgRemoteExec` in [addons/Viceroys-STALKER-ALife/config.cpp](addons/Viceroys-STALKER-ALife/config.cpp) declares which `VIC_fnc_*` functions are allowed via `remoteExec` / JIP. Respect those when changing call targets.
- Server-only checks: many files use `if (!isServer) exitWith {};` (see `initServer.sqf`). Keep server/client boundaries explicit.
- When server needs to return a value or run engine commands remotely, use provided helpers: `VIC_fnc_callServer`, `VIC_fnc_createGlobalMarker` (see `functions/core`).
- Functions that must be compiled at runtime use `call compile preprocessFileLineNumbers "..."` (see `initServer.sqf`). Preserve this pattern when refactoring.

4) Naming & coding conventions (discoverable patterns)
- Function files: `functions/<domain>/fn_<verb><Noun>.sqf`. Exposed CfgFunctions names follow `VIC_fnc_<name>` (see `config.cpp`).
- CBA settings live in `cba_settings.sqf`. Use `VIC_fnc_getSetting` to read them—do not hardcode config values.
- Global arrays and markers are shared across managers; prefer using existing helpers such as `VIC_fnc_sitePlaced`, `VIC_fnc_activateSite` to modify site state.

5) Developer workflows (what's in-repo)
- There are no CI/build scripts in this repository. Packaging into a PBO / installing the addon is performed outside the repo (typical Arma tooling). The repository layout expects to be used directly in Arma's `@mod`/addons folder or packaged externally.
- Runtime testing: enable `VSA_debugMode` (see `cba_settings.sqf`) to expose debug actions that spawn systems, mark caches, and run test spawns via the scroll menu.

6) Important files to inspect first (examples)
- Entry points: [addons/Viceroys-STALKER-ALife/initServer.sqf](addons/Viceroys-STALKER-ALife/initServer.sqf) and `functions/core/fn_masterInit.sqf`.
- Engine integration: [addons/Viceroys-STALKER-ALife/config.cpp](addons/Viceroys-STALKER-ALife/config.cpp) and [mod.cpp](mod.cpp).
- Settings and toggles: [addons/Viceroys-STALKER-ALife/cba_settings.sqf](addons/Viceroys-STALKER-ALife/cba_settings.sqf).
- Function patterns: `functions/core/fn_callServer.sqf`, `functions/core/fn_createGlobalMarker.sqf`, and other `functions/core` helpers.

7) Safe edit rules for an AI agent
- Preserve function signatures registered in `config.cpp` and avoid renaming `VIC_fnc_*` entries without updating `CfgFunctions`.
- Keep server/client boundary checks (`isServer`, `remoteExec` allowed list) intact.
- Use `VIC_fnc_getSetting` instead of literal constants when behavior is controlled by CBA options.
- When adding remote-execable functions, update `CfgRemoteExec` accordingly.

8) What I could not discover automatically
- Packaging/CI steps (PBO creation) are not present in-repo — assume manual packaging. If you want, I can add a recommended `pbo` build script template.

If any section looks incomplete or you want me to expand examples, tell me which area to focus on (entry points, remoteExec, CBA settings, or function refactors) and I will iterate.
