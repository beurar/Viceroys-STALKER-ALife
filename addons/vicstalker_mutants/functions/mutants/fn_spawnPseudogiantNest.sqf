/*
    Spawns a pseudogiant nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnPseudogiantNest"] call VIC_fnc_debugLog;

if !( ["Pseudogiant"] call VIC_fnc_isMutantEnabled ) exitWith {
    ["spawnPseudogiantNest exit: Pseudogiants disabled"] call VIC_fnc_debugLog;
};

private _classes = ["armst_giant", "armst_giant2"];
[_pos, selectRandom _classes] call VIC_fnc_spawnMutantNest;
