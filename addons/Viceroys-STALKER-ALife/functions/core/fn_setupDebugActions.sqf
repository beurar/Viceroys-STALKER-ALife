/*
    Adds interaction actions to the player for triggering major
    STALKER ALife systems. Only runs when VSA_debugMode is enabled.
*/

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["VSA_debugActionsAdded", false]) exitWith {};
missionNamespace setVariable ["VSA_debugActionsAdded", true];

player addAction ["Spawn Psy-Storm", {
    private _dur = ["VSA_stormDuration", 180] call VIC_fnc_getSetting;
    private _lStart = ["VSA_stormLightningStart", 6] call VIC_fnc_getSetting;
    private _lEnd   = ["VSA_stormLightningEnd", 12] call VIC_fnc_getSetting;
    private _dStart = ["VSA_stormDischargeStart", 6] call VIC_fnc_getSetting;
    private _dEnd   = ["VSA_stormDischargeEnd", 12] call VIC_fnc_getSetting;
    [_dur, _lStart, _lEnd, _dStart, _dEnd] remoteExec ["VIC_fnc_triggerPsyStorm", 2];
}];
player addAction ["Spawn Chemical Zone", {
    [getPos player, 100] remoteExec ["VIC_fnc_spawnChemicalZone", 2];
}];
player addAction ["Spawn Random Chemicals", {
    [getPos player, 200] remoteExec ["VIC_fnc_spawnRandomChemicalZones", 2];
}];
player addAction ["Spawn Valley Chemicals", {
    [getPos player, 200] remoteExec ["VIC_fnc_spawnValleyChemicalZones", 2];
}];
player addAction ["Spawn Permanent Fields", {
    for "_i" from 1 to 100 do {
        private _pos = [random worldSize, random worldSize, 0];
        [_pos, 1000, 1] remoteExec ["VIC_fnc_spawnAllAnomalyFields", 2];
    };
}];
player addAction ["Spawn Temporary Fields", {
    for "_i" from 1 to 100 do {
        private _pos = [random worldSize, random worldSize, 0];
        [_pos, 1000, 0] remoteExec ["VIC_fnc_spawnAllAnomalyFields", 2];
    };
}];
player addAction ["Cycle Anomaly Fields", {
    [] remoteExec ["VIC_fnc_cycleAnomalyFields", 2];
}];
player addAction ["Spawn Mutant Group", {
    [getPos player] remoteExec ["VIC_fnc_spawnMutantGroup", 2];
}];
player addAction ["Spawn Spook Zone", {
    [] remoteExec ["VIC_fnc_spawnSpookZone", 2];
}];
player addAction ["Spawn Zombies From Queue", {
    [] remoteExec ["VIC_fnc_spawnZombiesFromQueue", 2];
}];
player addAction ["Spawn Ambient Herds", {
    [] remoteExec ["VIC_fnc_spawnAmbientHerds", 2];
}];
player addAction ["Spawn Ambient Stalkers", {
    [] remoteExec ["VIC_fnc_spawnAmbientStalkers", 2];
}];
player addAction ["Spawn Stalker Camps", {
    [getPos player, 300] remoteExec ["VIC_fnc_spawnStalkerCamps", 2];
}];
player addAction ["Spawn Predator Attack", {
    [player] remoteExec ["VIC_fnc_spawnPredatorAttack", 2];
}];
player addAction ["Spawn Minefields", {
    [getPos player, 300] remoteExec ["VIC_fnc_spawnMinefields", 2];
}];
player addAction ["Spawn Ambush", {
    [getPos player, 300] remoteExec ["VIC_fnc_spawnAmbushes", 2];
}];
player addAction ["Generate Mutant Habitats", {
    [] remoteExec ["VIC_fnc_setupMutantHabitats", 2];
}];
player addAction ["Cycle Habitats", {
    [] remoteExec ["VIC_fnc_manageHabitats", 2];
}];
player addAction ["Mark All Buildings", { [] call VIC_fnc_markAllBuildings }];

["Debug actions added"] call VIC_fnc_debugLog;

true
