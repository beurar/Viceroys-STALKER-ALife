/*
    Spawns a pseudodog nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnPseudodogNest"] call VIC_fnc_debugLog;

[_pos, "O_ALF_Pseudodog"] call VIC_fnc_spawnMutantNest;
