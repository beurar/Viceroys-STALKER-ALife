/*
    Spawns a boar nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnBoarNest"] call VIC_fnc_debugLog;

if !( ["Boar"] call VIC_fnc_isMutantEnabled ) exitWith {
    ["spawnBoarNest exit: Boars disabled"] call VIC_fnc_debugLog;
};

private _classes = ["armst_boar", "armst_boar2"];
[_pos, selectRandom _classes] call VIC_fnc_spawnMutantNest;
