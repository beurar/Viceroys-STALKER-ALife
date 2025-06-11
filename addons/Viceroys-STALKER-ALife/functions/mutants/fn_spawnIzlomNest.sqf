/*
    Spawns an izlom nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnIzlomNest"] call VIC_fnc_debugLog;

[_pos, "O_ALF_Izlom"] call VIC_fnc_spawnMutantNest;
