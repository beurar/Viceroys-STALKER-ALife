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

"STALKER ALife initialization complete" remoteExec ["hint", 0];

true
