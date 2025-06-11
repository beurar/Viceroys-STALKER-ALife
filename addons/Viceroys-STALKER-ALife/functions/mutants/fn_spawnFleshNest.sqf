/*
    Spawns a flesh nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnFleshNest"] call VIC_fnc_debugLog;

[_pos, "O_ALF_Flesh"] call VIC_fnc_spawnMutantNest;
