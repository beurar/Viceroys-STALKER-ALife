/*
    Spawns a blind dog nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnBlindDogNest"] call VIC_fnc_debugLog;

[_pos, "O_ALF_BlindDog"] call VIC_fnc_spawnMutantNest;
