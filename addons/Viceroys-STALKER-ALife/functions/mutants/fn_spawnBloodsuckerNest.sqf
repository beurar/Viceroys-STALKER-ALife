/*
    Spawns a bloodsucker nest at the given position and records it for ALife management.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnBloodsuckerNest"] call VIC_fnc_debugLog;

[_pos, "O_ALF_Bloodsucker"] call VIC_fnc_spawnMutantNest;
