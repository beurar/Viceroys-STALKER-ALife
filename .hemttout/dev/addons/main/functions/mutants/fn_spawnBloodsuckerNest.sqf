/*
    Spawns a bloodsucker nest at the given position and records it for ALife management.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnBloodsuckerNest"] call VIC_fnc_debugLog;

if !( ["Bloodsucker"] call VIC_fnc_isMutantEnabled ) exitWith {
    ["spawnBloodsuckerNest exit: Bloodsuckers disabled"] call VIC_fnc_debugLog;
};

private _classes = ["armst_krovosos", "armst_krovosos2"];
[_pos, selectRandom _classes] call VIC_fnc_spawnMutantNest;
