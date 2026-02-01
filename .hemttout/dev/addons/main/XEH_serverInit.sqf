/*
    STALKER ALife – serverInit
    Server-only bootstrap and world initialization
*/



["postInit", {
    // Global arrays and managers
    drg_activeSpookZones = [];
    STALKER_activeSpooks = [];
    STALKER_activeHerds      = [];
    STALKER_activeHostiles   = [];
    STALKER_activePredators  = [];
    STALKER_mutantNests      = [];
    STALKER_anomalyFields    = [];
    STALKER_minefields       = [];
    STALKER_boobyTraps       = [];
    STALKER_iedSites         = [];
    STALKER_panicGroups      = [];
    STALKER_wanderers        = [];

    // Map bootstrap
    [] call VIC_fnc_initMap;

    // --- Minefields, IEDs, Booby Traps ---
    private _center = [0,0,0];
    private _worldSize = worldSize;
    [_center, _worldSize] call VIC_fnc_spawnMinefields;
    [_center, _worldSize] call VIC_fnc_spawnIEDSites;
    [_center, _worldSize] call VIC_fnc_spawnBoobyTraps;

    [format ["serverInit: %1 traps placed", count STALKER_boobyTraps]] call VIC_fnc_debugLog;

    // --- Wrecks ---
    private _wreckCount = ["VSA_wreckCount", 10] call VIC_fnc_getSetting;
    [_wreckCount] call VIC_fnc_spawnAbandonedVehicles;

    // --- Anomalies ---
    [_center, _worldSize, 1] call VIC_fnc_spawnAllAnomalyFields;
    [1] call VIC_fnc_spawnBridgeAnomalyFields;

    // --- Managers ---
    [] call VIC_fnc_initManagers;

    // --- Activity / proximity thread ---
    missionNamespace setVariable [
        "STALKER_activityRadius",
        ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting
    ];

    [] call VIC_fnc_registerEmissionHooks;

    if (isNil "VIC_activityThread") then {
        VIC_activityThread = [] spawn {
            sleep 8;
            while { true } do {
                [] call VIC_fnc_updateProximity;
                sleep 6;
            };
        };
    };

    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        [] call VIC_fnc_setupDebugActions;
        [] remoteExec ["VIC_fnc_markPlayerRanges", 0];
    };

    ["serverInit complete"] call VIC_fnc_debugLog;
}] call CBA_fnc_addEventHandler;

// --- Global kill tracking --------------------------------------------------
[
    "EntityKilled",
    {
        params ["_unit"];
        [_unit] call VIC_fnc_trackDeadForZombify;
        [_unit] call VIC_fnc_markDeathLocation;
    }
] call CBA_fnc_addEventHandler;
