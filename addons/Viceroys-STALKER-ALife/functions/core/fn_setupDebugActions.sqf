/*
    Adds interaction actions to the player for triggering major
    STALKER ALife systems. Only runs when VSA_debugMode is enabled.
*/

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["VSA_debugActionsAdded", false]) exitWith {};
missionNamespace setVariable ["VSA_debugActionsAdded", true];

// --- Spawning Actions ---
player addAction ["<t color='#ff0000'>Spawn Psy-Storm</t>", {
    private _dur = ["VSA_stormDuration", 180] call VIC_fnc_getSetting;
    private _lStart = ["VSA_stormLightningStart", 6] call VIC_fnc_getSetting;
    private _lEnd   = ["VSA_stormLightningEnd", 12] call VIC_fnc_getSetting;
    private _dStart = ["VSA_stormDischargeStart", 6] call VIC_fnc_getSetting;
    private _dEnd   = ["VSA_stormDischargeEnd", 12] call VIC_fnc_getSetting;
    if (isServer) then {
        [_dur, _lStart, _lEnd, _dStart, _dEnd] call VIC_fnc_triggerPsyStorm;
    } else {
        [_dur, _lStart, _lEnd, _dStart, _dEnd] remoteExec ["VIC_fnc_triggerPsyStorm", 2];
    };
}];
player addAction ["<t color='#ff0000'>Trigger Blowout</t>", {
    if (isServer) then {
        [] call VIC_fnc_triggerBlowout;
    } else {
        [] remoteExec ["VIC_fnc_triggerBlowout", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Chemical Zone</t>", {
    if (isServer) then {
        [getPos player, 100] call VIC_fnc_spawnChemicalZone;
    } else {
        [getPos player, 100] remoteExec ["VIC_fnc_spawnChemicalZone", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Random Chemicals</t>", {
    if (isServer) then {
        [getPos player, 200] call VIC_fnc_spawnRandomChemicalZones;
    } else {
        [getPos player, 200] remoteExec ["VIC_fnc_spawnRandomChemicalZones", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Valley Chemicals</t>", {
    if (isServer) then {
        [getPos player, 200] call VIC_fnc_spawnValleyChemicalZones;
    } else {
        [getPos player, 200] remoteExec ["VIC_fnc_spawnValleyChemicalZones", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Stable Fields</t>", {
    for "_i" from 1 to 100 do {
        private _pos = [random worldSize, random worldSize, 0];
        if (isServer) then {
            [_pos, 1000, 1] call VIC_fnc_spawnAllAnomalyFields;
        } else {
            [_pos, 1000, 1] remoteExec ["VIC_fnc_spawnAllAnomalyFields", 2];
        };
    };
}];
player addAction ["<t color='#ff0000'>Spawn Unstable Fields</t>", {
    for "_i" from 1 to 100 do {
        private _pos = [random worldSize, random worldSize, 0];
        if (isServer) then {
            [_pos, 1000, 0] call VIC_fnc_spawnAllAnomalyFields;
        } else {
            [_pos, 1000, 0] remoteExec ["VIC_fnc_spawnAllAnomalyFields", 2];
        };
    };
}];
// --- Cycle/Manager Actions ---
player addAction ["<t color='#0000ff'>Cycle Anomaly Fields</t>", {
    if (isServer) then {
        [] call VIC_fnc_cycleAnomalyFields;
    } else {
        [] remoteExec ["VIC_fnc_cycleAnomalyFields", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Mutant Group</t>", {
    if (isServer) then {
        [getPos player] call VIC_fnc_spawnMutantGroup;
    } else {
        [getPos player] remoteExec ["VIC_fnc_spawnMutantGroup", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Spook Zone</t>", {
    if (isServer) then {
        [] call VIC_fnc_spawnSpookZone;
    } else {
        [] remoteExec ["VIC_fnc_spawnSpookZone", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Zombies From Queue</t>", {
    if (isServer) then {
        [] call VIC_fnc_spawnZombiesFromQueue;
    } else {
        [] remoteExec ["VIC_fnc_spawnZombiesFromQueue", 2];
    };
}];
player addAction ["<t color='#ff0000'>Trigger Necroplague</t>", {
    private _z = ["VSA_necroZombies",5] call VIC_fnc_getSetting;
    private _h = ["VSA_necroHordes",2] call VIC_fnc_getSetting;
    if (isServer) then {
        [_z, _h, true] call VIC_fnc_triggerNecroplague;
    } else {
        [_z, _h, true] remoteExec ["VIC_fnc_triggerNecroplague", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Ambient Herds</t>", {
    if (isServer) then {
        [] call VIC_fnc_spawnAmbientHerds;
    } else {
        [] remoteExec ["VIC_fnc_spawnAmbientHerds", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Ambient Stalkers</t>", {
    if (isServer) then {
        [] call VIC_fnc_spawnAmbientStalkers;
    } else {
        [] remoteExec ["VIC_fnc_spawnAmbientStalkers", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Stalker Camps</t>", {
    if (isServer) then {
        [getPos player, 300] call VIC_fnc_spawnStalkerCamps;
    } else {
        [getPos player, 300] remoteExec ["VIC_fnc_spawnStalkerCamps", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Sniper</t>", {
    if (isServer) then {
        [getPos player] call VIC_fnc_spawnSniper;
    } else {
        [getPos player] remoteExec ["VIC_fnc_spawnSniper", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Predator Attack</t>", {
    if (isServer) then {
        [player] call VIC_fnc_spawnPredatorAttack;
    } else {
        [player] remoteExec ["VIC_fnc_spawnPredatorAttack", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Minefields</t>", {
    if (isServer) then {
        [getPos player, 300] call VIC_fnc_spawnMinefields;
    } else {
        [getPos player, 300] remoteExec ["VIC_fnc_spawnMinefields", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Booby Traps</t>", {
    if (isServer) then {
        [getPos player, 200] call VIC_fnc_spawnBoobyTraps;
    } else {
        [getPos player, 200] remoteExec ["VIC_fnc_spawnBoobyTraps", 2];
    };
}];
player addAction ["<t color='#0000ff'>Start Minefield Logic</t>", {
    if (isServer) then {
        [] call VIC_fnc_startMinefieldManager;
    } else {
        [] remoteExec ["VIC_fnc_startMinefieldManager", 2];
    };
}];
player addAction ["<t color='#ff0000'>Spawn Ambush</t>", {
    if (isServer) then {
        [getPos player, 300] call VIC_fnc_spawnAmbushes;
    } else {
        [getPos player, 300] remoteExec ["VIC_fnc_spawnAmbushes", 2];
    };
}];
player addAction ["<t color='#0000ff'>Start Ambush Logic</t>", {
    if (isServer) then {
        [] call VIC_fnc_startAmbushManager;
    } else {
        [] remoteExec ["VIC_fnc_startAmbushManager", 2];
    };
}];
player addAction ["<t color='#0000ff'>Generate Mutant Habitats</t>", {
    if (isServer) then {
        [] call VIC_fnc_setupMutantHabitats;
    } else {
        [] remoteExec ["VIC_fnc_setupMutantHabitats", 2];
    };
}];
player addAction ["<t color='#0000ff'>Cycle Habitats</t>", {
    if (isServer) then {
        [] call VIC_fnc_manageHabitats;
    } else {
        [] remoteExec ["VIC_fnc_manageHabitats", 2];
    };
}];
player addAction ["<t color='#0000ff'>Trigger AI Panic</t>", {
    if (isServer) then {
        [] call VIC_fnc_triggerAIPanic;
    } else {
        [] remoteExec ["VIC_fnc_triggerAIPanic", 2];
    };
}];
player addAction ["<t color='#0000ff'>Reset AI Behaviour</t>", {
    if (isServer) then {
        [] call VIC_fnc_resetAIBehavior;
    } else {
        [] remoteExec ["VIC_fnc_resetAIBehavior", 2];
    };
}];
player addAction ["<t color='#0000ff'>Toggle Field Avoidance</t>", {
    if (isServer) then {
        [] call VIC_fnc_toggleFieldAvoid;
    } else {
        [] remoteExec ["VIC_fnc_toggleFieldAvoid", 2];
    };
}];
// --- Marking Actions ---
player addAction ["<t color='#ffff00'>Mark All Buildings</t>", {
    if (isServer) then {
        [] call VIC_fnc_markAllBuildings;
    } else {
        [] remoteExec ["VIC_fnc_markAllBuildings", 2];
    };
}];
player addAction ["<t color='#ffff00'>Mark Rock Clusters</t>", {
    if (isServer) then {
        [] call VIC_fnc_markRockClusters;
    } else {
        [] remoteExec ["VIC_fnc_markRockClusters", 2];
    };
}];
player addAction ["<t color='#ffff00'>Mark Sniper Spots</t>", {
    if (isServer) then {
        [] call VIC_fnc_markSniperSpots;
    } else {
        [] remoteExec ["VIC_fnc_markSniperSpots", 2];
    };
}];
player addAction ["<t color='#ffff00'>Mark Swamps</t>", {
    if (isServer) then {
        [] call VIC_fnc_markSwamps;
    } else {
        [] remoteExec ["VIC_fnc_markSwamps", 2];
    };
}];
player addAction ["<t color='#ffff00'>Mark Beach Spots</t>", { [] call VIC_fnc_markBeaches }];
player addAction ["<t color='#ffff00'>Mark Valleys</t>", {
    if (isServer) then {
        [] call VIC_fnc_markValleys;
    } else {
        [] remoteExec ["VIC_fnc_markValleys", 2];
    };
}];
player addAction ["<t color='#ffff00'>Mark Building Clusters</t>", {
    if (isServer) then {
        [] call VIC_fnc_markBuildingClusters;
    } else {
        [] remoteExec ["VIC_fnc_markBuildingClusters", 2];
    };
}];
player addAction ["<t color='#ffff00'>Mark Hidden Spot</t>", {
    if (isServer) then {
        [] call VIC_fnc_markHiddenPosition;
    } else {
        [] remoteExec ["VIC_fnc_markHiddenPosition", 2];
    };
}];
player addAction ["<t color='#ffff00'>Mark Building Cover</t>", {
    if (isServer) then {
        [] call VIC_fnc_markBuildingCoverSpot;
    } else {
        [] remoteExec ["VIC_fnc_markBuildingCoverSpot", 2];
    };
}];
player addAction ["<t color='#ffff00'>Mark Bridges</t>", {
    if (isServer) then {
        [] call VIC_fnc_markBridges;
    } else {
        [] remoteExec ["VIC_fnc_markBridges", 2];
    };
}];
player addAction ["<t color='#ffff00'>Mark Roads</t>", {
    if (isServer) then {
        [] call VIC_fnc_markRoads;
    } else {
        [] remoteExec ["VIC_fnc_markRoads", 2];
    };
}];
player addAction ["<t color='#ffff00'>Cache Map Wrecks</t>", {
    if (isServer) then {
        [] call VIC_fnc_findWrecks;
    } else {
        [] remoteExec ["VIC_fnc_findWrecks", 2];
    };
}];
player addAction ["<t color='#ffff00'>Cache Sniper Spots</t>", {
    if (isServer) then {
        [] call VIC_fnc_findSniperSpots;
    } else {
        [] remoteExec ["VIC_fnc_findSniperSpots", 2];
    };
}];
player addAction ["<t color='#ffff00'>Cache Roads</t>", {
    if (isServer) then {
        [] call VIC_fnc_findRoads;
    } else {
        [] remoteExec ["VIC_fnc_findRoads", 2];
    };
}];
player addAction ["<t color='#ffff00'>Cache Crossroads</t>", {
    if (isServer) then {
        [] call VIC_fnc_findCrossroads;
    } else {
        [] remoteExec ["VIC_fnc_findCrossroads", 2];
    };
}];
player addAction ["<t color='#ffff00'>Cache Bridges</t>", {
    if (isServer) then {
        [] call VIC_fnc_findBridges;
    } else {
        [] remoteExec ["VIC_fnc_findBridges", 2];
    };
}];
player addAction ["<t color='#ffff00'>Cache Valleys</t>", {
    if (isServer) then {
        [] call VIC_fnc_findValleys;
    } else {
        [] remoteExec ["VIC_fnc_findValleys", 2];
    };
}];
player addAction ["<t color='#ffff00'>Cache Beach Spots</t>", {
    if (isServer) then {
        [] call VIC_fnc_findBeachesInMap;
    } else {
        [] remoteExec ["VIC_fnc_findBeachesInMap", 2];
    };
}];
player addAction ["<t color='#ffff00'>Cache Swamps</t>", {
    if (isServer) then {
        [] call VIC_fnc_findSwamps;
    } else {
        [] remoteExec ["VIC_fnc_findSwamps", 2];
    };
}];

["Debug actions added"] call VIC_fnc_debugLog;

true
