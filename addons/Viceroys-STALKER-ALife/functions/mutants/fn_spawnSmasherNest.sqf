/*
    Spawns a WebKnight smasher nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnSmasherNest"] call VIC_fnc_debugLog;

[_pos, "WBK_Smasher"] call VIC_fnc_spawnMutantNest;
