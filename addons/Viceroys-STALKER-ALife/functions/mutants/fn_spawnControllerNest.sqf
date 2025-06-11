/*
    Spawns a controller nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnControllerNest"] call VIC_fnc_debugLog;

[_pos, "O_ALF_Controller"] call VIC_fnc_spawnMutantNest;
