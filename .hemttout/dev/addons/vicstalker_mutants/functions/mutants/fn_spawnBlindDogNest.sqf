/*
    Spawns a blind dog nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnBlindDogNest"] call VIC_fnc_debugLog;

if !( ["Blind Dog"] call VIC_fnc_isMutantEnabled ) exitWith {
    ["spawnBlindDogNest exit: Blind Dogs disabled"] call VIC_fnc_debugLog;
};

private _classes = ["armst_blinddog1", "armst_blinddog2", "armst_blinddog3"];
[_pos, selectRandom _classes] call VIC_fnc_spawnMutantNest;
