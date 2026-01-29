/*
    Spawns a controller nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnControllerNest"] call VIC_fnc_debugLog;

if !( ["Controller"] call VIC_fnc_isMutantEnabled ) exitWith {
    ["spawnControllerNest exit: Controllers disabled"] call VIC_fnc_debugLog;
};

private _classes = ["armst_controller_new", "armst_controller_new2", "armst_controller_new3"];
[_pos, selectRandom _classes] call VIC_fnc_spawnMutantNest;
