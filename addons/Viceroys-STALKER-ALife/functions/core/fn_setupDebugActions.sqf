/*
    Adds interaction actions to the player for triggering major
    STALKER ALife systems. Only runs when VSA_debugMode is enabled.
*/

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["VSA_debugActionsAdded", false]) exitWith {};
missionNamespace setVariable ["VSA_debugActionsAdded", true];

player addAction ["Spawn Psy-Storm", { [] call VIC_fnc_triggerPsyStorm }];
player addAction ["Spawn Radiation Zone", { [getPos player, 100] call VIC_fnc_spawnRadiationZone }];
player addAction ["Spawn Random Radiation", { [getPos player, 200] call VIC_fnc_spawnRandomRadiationZones }];
player addAction ["Spawn Anomaly Fields", { [getPos player, 200] call VIC_fnc_spawnAllAnomalyFields }];
player addAction ["Spawn Mutant Group", { [getPos player] call VIC_fnc_spawnMutantGroup }];
player addAction ["Spawn Spook Zone", { [] call VIC_fnc_spawnSpookZone }];
player addAction ["Spawn Zombies From Queue", { [] call VIC_fnc_spawnZombiesFromQueue }];
player addAction ["Spawn Ambient Herds", { [] call VIC_fnc_spawnAmbientHerds }];
player addAction ["Generate Mutant Habitats", { [] call VIC_fnc_setupMutantHabitats }];

["Debug actions added"] call VIC_fnc_debugLog;

true
