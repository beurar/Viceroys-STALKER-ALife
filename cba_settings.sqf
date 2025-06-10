/* Default CBA settings for ALife systems */

// Hostile mutant spawns
["ALF_mutantGroupCount", "SLIDER", [1, 5, 1], 1, "Number of mutant groups after an emission"] call CBA_fnc_addSetting;
["ALF_mutantThreat", "SLIDER", [1, 10, 1], 3, "Units per hostile group"] call CBA_fnc_addSetting;
["ALF_mutantNightOnly", "CHECKBOX", false, "Spawn hostile groups only at night"] call CBA_fnc_addSetting;

// Ambient herds
["ALF_ambientHerdCount", "SLIDER", [0, 5, 1], 2, "Number of roaming herds"] call CBA_fnc_addSetting;
["ALF_ambientHerdSize", "SLIDER", [1, 8, 1], 4, "Units per roaming herd"] call CBA_fnc_addSetting;
["ALF_ambientNightOnly", "CHECKBOX", false, "Spawn herds only at night"] call CBA_fnc_addSetting;
