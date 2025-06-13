/*
    Adds interaction actions to the player for triggering major
    STALKER ALife systems. Only runs when VSA_debugMode is enabled.
*/

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["VSA_debugActionsAdded", false]) exitWith {};
missionNamespace setVariable ["VSA_debugActionsAdded", true];

player addAction ["Spawn Psy-Storm", {
    private _dur = ["VSA_stormDuration", 180] call VIC_fnc_getSetting;
    private _start = ["VSA_stormIntensityStart", 2] call VIC_fnc_getSetting;
    private _end = ["VSA_stormIntensityEnd", 6] call VIC_fnc_getSetting;
    [_dur, _start, _end] call VIC_fnc_triggerPsyStorm
}];
player addAction ["Spawn Chemical Zone", { [getPos player, 100] call VIC_fnc_spawnChemicalZone }];
player addAction ["Spawn Random Chemicals", { [getPos player, 200] call VIC_fnc_spawnRandomChemicalZones }];
player addAction ["Spawn Anomaly Fields", { [getPos player, 200] call VIC_fnc_spawnAllAnomalyFields }];
player addAction ["Spawn Mutant Group", { [getPos player] call VIC_fnc_spawnMutantGroup }];
player addAction ["Spawn Spook Zone", { [] call VIC_fnc_spawnSpookZone }];
player addAction ["Spawn Zombies From Queue", { [] call VIC_fnc_spawnZombiesFromQueue }];
player addAction ["Spawn Ambient Herds", { [] call VIC_fnc_spawnAmbientHerds }];
player addAction ["Spawn Predator Attack", { [player] call VIC_fnc_spawnPredatorAttack }];
player addAction ["Spawn Minefields", { [getPos player, 300] call VIC_fnc_spawnMinefields }];
player addAction ["Generate Mutant Habitats", { [] call VIC_fnc_setupMutantHabitats }];
player addAction ["Cycle Habitats", { [] call VIC_fnc_manageHabitats }];
player addAction ["Mark All Buildings", { [] call VIC_fnc_markAllBuildings }];

["Debug actions added"] call VIC_fnc_debugLog;

true
