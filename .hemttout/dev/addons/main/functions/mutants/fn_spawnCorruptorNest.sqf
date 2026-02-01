/*
    Spawns a WebKnight corruptor nest at the given position.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnCorruptorNest"] call VIC_fnc_debugLog;

if !( ["Corruptor"] call VIC_fnc_isMutantEnabled ) exitWith {
    ["spawnCorruptorNest exit: Corruptors disabled"] call VIC_fnc_debugLog;
};

[_pos, "WBK_SpecialZombie_Corrupted_3"] call VIC_fnc_spawnMutantNest;
