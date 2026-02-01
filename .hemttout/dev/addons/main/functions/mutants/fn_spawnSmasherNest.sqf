/*
    Spawns a WebKnight smasher nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnSmasherNest"] call VIC_fnc_debugLog;

if !( ["Smasher"] call VIC_fnc_isMutantEnabled ) exitWith {
    ["spawnSmasherNest exit: Smashers disabled"] call VIC_fnc_debugLog;
};

[_pos, "WBK_SpecialZombie_Smasher_3"] call VIC_fnc_spawnMutantNest;
