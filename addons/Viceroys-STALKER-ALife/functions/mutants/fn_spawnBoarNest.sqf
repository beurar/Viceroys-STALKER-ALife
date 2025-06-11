/*
    Spawns a boar nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnBoarNest"] call VIC_fnc_debugLog;

[_pos, "O_ALF_Boar"] call VIC_fnc_spawnMutantNest;
