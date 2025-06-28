/*
    Caches all map positions required by STALKER ALife systems.
*/


["initMap"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

// Load cached data when available to avoid expensive scans
private _roads = ["STALKER_roads"] call VIC_fnc_loadCache;
if (isNil {_roads}) then {
    _roads = [] call VIC_fnc_findRoads;
    ["STALKER_roads", _roads] call VIC_fnc_saveCache;
};

// Land zones are optional but load if present
["STALKER_landZones"] call VIC_fnc_loadCache;

[] call VIC_fnc_findRockClusters;
[] call VIC_fnc_findSniperSpots;
[] call VIC_fnc_findSwamps;
[] call VIC_fnc_findBeachesInMap;
[] call VIC_fnc_findValleys;
[] call VIC_fnc_findBridges;
[] call VIC_fnc_findCrossroads;
[] call VIC_fnc_findBuildingClusters;
[] call VIC_fnc_findWrecks;

// Automatically display cached points when debug mode is active
if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
    [] remoteExec ["VIC_fnc_markRockClusters", 0];
    [format ["initMap: placed %1 rock cluster markers", count STALKER_rockClusterMarkers]] call VIC_fnc_debugLog;

    [] remoteExec ["VIC_fnc_markSniperSpots", 0];
    [format ["initMap: placed %1 sniper spot markers", count STALKER_sniperSpotMarkers]] call VIC_fnc_debugLog;

    [] remoteExec ["VIC_fnc_markSwamps", 0];
    [format ["initMap: placed %1 swamp markers", count STALKER_swampMarkers]] call VIC_fnc_debugLog;

    [] remoteExec ["VIC_fnc_markBeaches", 0];
    [format ["initMap: placed %1 beach markers", count STALKER_beachMarkers]] call VIC_fnc_debugLog;

    [] remoteExec ["VIC_fnc_markValleys", 0];
    [format ["initMap: placed %1 valley markers", count STALKER_valleyMarkers]] call VIC_fnc_debugLog;

    [] remoteExec ["VIC_fnc_markLandZones", 0];
    [format ["initMap: placed %1 land zone markers", count STALKER_landZoneMarkers]] call VIC_fnc_debugLog;

    [] remoteExec ["VIC_fnc_markBuildingClusters", 0];
    [format ["initMap: placed %1 building cluster markers", count STALKER_buildingClusterMarkers]] call VIC_fnc_debugLog;

    [] remoteExec ["VIC_fnc_markBridges", 0];
    [format ["initMap: placed %1 bridge markers", count STALKER_bridgeMarkers]] call VIC_fnc_debugLog;

    [] remoteExec ["VIC_fnc_markRoads", 0];
    [format ["initMap: placed %1 road markers", count STALKER_roadMarkers]] call VIC_fnc_debugLog;
    [format ["initMap: placed %1 crossroad markers", count STALKER_crossroadMarkers]] call VIC_fnc_debugLog;

    [] remoteExec ["VIC_fnc_markWrecks", 0];
    [format ["initMap: placed %1 wreck markers", count STALKER_wreckMarkers]] call VIC_fnc_debugLog;
};

"STALKER ALife initialization complete" remoteExec ["hint", 0];

true
