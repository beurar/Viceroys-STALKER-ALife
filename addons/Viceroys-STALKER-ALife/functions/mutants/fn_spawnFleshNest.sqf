/*
    Spawns a flesh nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnFleshNest"] call VIC_fnc_debugLog;

if !( ["Flesh"] call VIC_fnc_isMutantEnabled ) exitWith {
    ["spawnFleshNest exit: Flesh disabled"] call VIC_fnc_debugLog;
};

private _classes = ["armst_PLOT", "armst_PLOT2"];
[_pos, selectRandom _classes] call VIC_fnc_spawnMutantNest;
