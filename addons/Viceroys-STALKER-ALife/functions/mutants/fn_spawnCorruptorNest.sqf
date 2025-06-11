/*
    Spawns a WebKnight corruptor nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnCorruptorNest"] call VIC_fnc_debugLog;

[_pos, "WBK_Corruptor"] call VIC_fnc_spawnMutantNest;
