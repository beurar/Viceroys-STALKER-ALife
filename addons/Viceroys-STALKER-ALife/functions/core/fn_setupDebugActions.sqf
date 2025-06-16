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
    if (isServer) then {
        [_dur, _lStart, _lEnd, _dStart, _dEnd] call VIC_fnc_triggerPsyStorm;
    } else {
        [_dur, _lStart, _lEnd, _dStart, _dEnd] remoteExec ["VIC_fnc_triggerPsyStorm", 2];
    };
}];
player addAction ["Trigger Blowout", {
    if (isServer) then {
        [] spawn tts_emission_fnc_startEmission;
    } else {
        { [] spawn tts_emission_fnc_startEmission } remoteExec [2];
    };
}];
player addAction ["Spawn Chemical Zone", {
    if (isServer) then {
        [getPos player, 100] call VIC_fnc_spawnChemicalZone;
    } else {
        [getPos player, 100] remoteExec ["VIC_fnc_spawnChemicalZone", 2];
    };
}];
player addAction ["Spawn Random Chemicals", {
    if (isServer) then {
        [getPos player, 200] call VIC_fnc_spawnRandomChemicalZones;
    } else {
        [getPos player, 200] remoteExec ["VIC_fnc_spawnRandomChemicalZones", 2];
    };
}];
player addAction ["Spawn Valley Chemicals", {
    if (isServer) then {
        [getPos player, 200] call VIC_fnc_spawnValleyChemicalZones;
    } else {
        [getPos player, 200] remoteExec ["VIC_fnc_spawnValleyChemicalZones", 2];
    };
}];
player addAction ["Spawn Permanent Fields", {
    for "_i" from 1 to 100 do {
        private _pos = [random worldSize, random worldSize, 0];
        if (isServer) then {
            [_pos, 1000, 1] call VIC_fnc_spawnAllAnomalyFields;
        } else {
            [_pos, 1000, 1] remoteExec ["VIC_fnc_spawnAllAnomalyFields", 2];
        };
    };
}];
player addAction ["Spawn Temporary Fields", {
    for "_i" from 1 to 100 do {
        private _pos = [random worldSize, random worldSize, 0];
        if (isServer) then {
            [_pos, 1000, 0] call VIC_fnc_spawnAllAnomalyFields;
        } else {
            [_pos, 1000, 0] remoteExec ["VIC_fnc_spawnAllAnomalyFields", 2];
        };
    };
}];
player addAction ["Cycle Anomaly Fields", {
    if (isServer) then {
        [] call VIC_fnc_cycleAnomalyFields;
    } else {
        [] remoteExec ["VIC_fnc_cycleAnomalyFields", 2];
    };
}];
player addAction ["Spawn Mutant Group", {
    if (isServer) then {
        [getPos player] call VIC_fnc_spawnMutantGroup;
    } else {
        [getPos player] remoteExec ["VIC_fnc_spawnMutantGroup", 2];
    };
}];
player addAction ["Spawn Spook Zone", {
    if (isServer) then {
        [] call VIC_fnc_spawnSpookZone;
    } else {
        [] remoteExec ["VIC_fnc_spawnSpookZone", 2];
    };
}];
player addAction ["Spawn Zombies From Queue", {
    if (isServer) then {
        [] call VIC_fnc_spawnZombiesFromQueue;
    } else {
        [] remoteExec ["VIC_fnc_spawnZombiesFromQueue", 2];
    };
}];
player addAction ["Trigger Necroplague", {
    private _z = ["VSA_necroZombies",5] call VIC_fnc_getSetting;
    private _h = ["VSA_necroHordes",2] call VIC_fnc_getSetting;
    if (isServer) then {
        [_z, _h, true] call VIC_fnc_triggerNecroplague;
    } else {
        [_z, _h, true] remoteExec ["VIC_fnc_triggerNecroplague", 2];
    };
}];
player addAction ["Spawn Ambient Herds", {
    if (isServer) then {
        [] call VIC_fnc_spawnAmbientHerds;
    } else {
        [] remoteExec ["VIC_fnc_spawnAmbientHerds", 2];
    };
}];
player addAction ["Spawn Ambient Stalkers", {
    if (isServer) then {
        [] call VIC_fnc_spawnAmbientStalkers;
    } else {
        [] remoteExec ["VIC_fnc_spawnAmbientStalkers", 2];
    };
}];
player addAction ["Spawn Stalker Camps", {
    if (isServer) then {
        [getPos player, 300] call VIC_fnc_spawnStalkerCamps;
    } else {
        [getPos player, 300] remoteExec ["VIC_fnc_spawnStalkerCamps", 2];
    };
}];
player addAction ["Spawn Predator Attack", {
    if (isServer) then {
        [player] call VIC_fnc_spawnPredatorAttack;
    } else {
        [player] remoteExec ["VIC_fnc_spawnPredatorAttack", 2];
    };
}];
player addAction ["Spawn Minefields", {
    if (isServer) then {
        [getPos player, 300] call VIC_fnc_spawnMinefields;
    } else {
        [getPos player, 300] remoteExec ["VIC_fnc_spawnMinefields", 2];
    };
}];
player addAction ["Spawn Booby Traps", {
    if (isServer) then {
        [getPos player, 200] call VIC_fnc_spawnBoobyTraps;
    } else {
        [getPos player, 200] remoteExec ["VIC_fnc_spawnBoobyTraps", 2];
    };
}];
player addAction ["Start Minefield Logic", {
    if (isServer) then {
        [] call VIC_fnc_startMinefieldManager;
    } else {
        [] remoteExec ["VIC_fnc_startMinefieldManager", 2];
    };
}];
player addAction ["Spawn Ambush", {
    if (isServer) then {
        [getPos player, 300] call VIC_fnc_spawnAmbushes;
    } else {
        [getPos player, 300] remoteExec ["VIC_fnc_spawnAmbushes", 2];
    };
}];
player addAction ["Start Ambush Logic", {
    if (isServer) then {
        [] call VIC_fnc_startAmbushManager;
    } else {
        [] remoteExec ["VIC_fnc_startAmbushManager", 2];
    };
}];
player addAction ["Generate Mutant Habitats", {
    if (isServer) then {
        [] call VIC_fnc_setupMutantHabitats;
    } else {
        [] remoteExec ["VIC_fnc_setupMutantHabitats", 2];
    };
}];
player addAction ["Cycle Habitats", {
    if (isServer) then {
        [] call VIC_fnc_manageHabitats;
    } else {
        [] remoteExec ["VIC_fnc_manageHabitats", 2];
    };
}];
player addAction ["Trigger AI Panic", {
    if (isServer) then {
        [] call VIC_fnc_triggerAIPanic;
    } else {
        [] remoteExec ["VIC_fnc_triggerAIPanic", 2];
    };
}];
player addAction ["Reset AI Behaviour", {
    if (isServer) then {
        [] call VIC_fnc_resetAIBehavior;
    } else {
        [] remoteExec ["VIC_fnc_resetAIBehavior", 2];
    };
}];
player addAction ["Toggle Field Avoidance", {
    if (isServer) then {
        [] call VIC_fnc_toggleFieldAvoid;
    } else {
        [] remoteExec ["VIC_fnc_toggleFieldAvoid", 2];
    };
}];
player addAction ["Mark All Buildings", {
    if (isServer) then {
        [] call VIC_fnc_markAllBuildings;
    } else {
        [] remoteExec ["VIC_fnc_markAllBuildings", 2];
    };
}];
player addAction ["Mark Rock Clusters", {
    if (isServer) then {
        [] call VIC_fnc_markRockClusters;
    } else {
        [] remoteExec ["VIC_fnc_markRockClusters", 2];
    };
}];
player addAction ["Mark Sniper Spots", {
    if (isServer) then {
        [] call VIC_fnc_markSniperSpots;
    } else {
        [] remoteExec ["VIC_fnc_markSniperSpots", 2];
    };
}];
player addAction ["Mark Swamps", {
    if (isServer) then {
        [] call VIC_fnc_markSwamps;
    } else {
        [] remoteExec ["VIC_fnc_markSwamps", 2];
    };
}];
player addAction ["Mark Beach Spots", { [] call VIC_fnc_markBeaches }];
player addAction ["Mark Valleys", {
    if (isServer) then {
        [] call VIC_fnc_markValleys;
    } else {
        [] remoteExec ["VIC_fnc_markValleys", 2];
    };
}];
player addAction ["Mark Building Clusters", {
    if (isServer) then {
        [] call VIC_fnc_markBuildingClusters;
    } else {
        [] remoteExec ["VIC_fnc_markBuildingClusters", 2];
    };
}];
player addAction ["Mark Hidden Spot", {
    if (isServer) then {
        [] call VIC_fnc_markHiddenPosition;
    } else {
        [] remoteExec ["VIC_fnc_markHiddenPosition", 2];
    };
}];
player addAction ["Mark Building Cover", {
    if (isServer) then {
        [] call VIC_fnc_markBuildingCoverSpot;
    } else {
        [] remoteExec ["VIC_fnc_markBuildingCoverSpot", 2];
    };
}];
player addAction ["Mark Bridges", {
    if (isServer) then {
        [] call VIC_fnc_markBridges;
    } else {
        [] remoteExec ["VIC_fnc_markBridges", 2];
    };
}];

["Debug actions added"] call VIC_fnc_debugLog;

true
