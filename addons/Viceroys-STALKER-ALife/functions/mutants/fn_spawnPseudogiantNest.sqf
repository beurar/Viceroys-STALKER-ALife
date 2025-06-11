/*
    Spawns a pseudogiant nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnPseudogiantNest"] call VIC_fnc_debugLog;

[_pos, "O_ALF_Pseudogiant"] call VIC_fnc_spawnMutantNest;
