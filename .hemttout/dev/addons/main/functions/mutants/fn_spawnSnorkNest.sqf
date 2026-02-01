/*
    Spawns a snork nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnSnorkNest"] call VIC_fnc_debugLog;

if !( ["Snork"] call VIC_fnc_isMutantEnabled ) exitWith {
    ["spawnSnorkNest exit: Snorks disabled"] call VIC_fnc_debugLog;
};

[_pos, "armst_snork"] call VIC_fnc_spawnMutantNest;
