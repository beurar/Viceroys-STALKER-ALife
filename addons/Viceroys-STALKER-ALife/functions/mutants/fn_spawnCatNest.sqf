/*
    Spawns a cat nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnCatNest"] call VIC_fnc_debugLog;

[_pos, "armst_cat"] call VIC_fnc_spawnMutantNest;
