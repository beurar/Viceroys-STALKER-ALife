/*
    Rebuilds all map points from scratch and caches the results.
*/

["regenMapPoints"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

private _roads = [] call VIC_fnc_findRoads;
["STALKER_roads", _roads] call VIC_fnc_saveCache;

private _zones = [] call VIC_fnc_findLandZones;
["STALKER_landZones", _zones] call VIC_fnc_saveCache;

[] call VIC_fnc_findRockClusters;
[] call VIC_fnc_findSniperSpots;
[] call VIC_fnc_findSwamps;
[] call VIC_fnc_findBeachesInMap;
[] call VIC_fnc_findValleys;
[] call VIC_fnc_findBridges;
[] call VIC_fnc_findCrossroads;
[] call VIC_fnc_findBuildingClusters;
[] call VIC_fnc_findWrecks;

"Map points regenerated" remoteExec ["hint", 0];

true
