/*
    Rebuilds all map points from scratch and caches the results.
*/

["regenMapPoints"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

private _roads = [] call VIC_fnc_findRoads;
["STALKER_roads", _roads] call VIC_fnc_saveCache;

private _zones = [] call VIC_fnc_findLandZones;
["STALKER_landZones", _zones] call VIC_fnc_saveCache;

private _rockClusters = [] call VIC_fnc_findRockClusters;
["STALKER_rockClusters", _rockClusters] call VIC_fnc_saveCache;

private _sniperSpots = [] call VIC_fnc_findSniperSpots;
["STALKER_sniperSpots", _sniperSpots] call VIC_fnc_saveCache;

private _swamps = [] call VIC_fnc_findSwamps;
["STALKER_swamps", _swamps] call VIC_fnc_saveCache;

private _beaches = [] call VIC_fnc_findBeachesInMap;
["STALKER_beachSpots", _beaches] call VIC_fnc_saveCache;

private _valleys = [] call VIC_fnc_findValleys;
["STALKER_valleys", _valleys] call VIC_fnc_saveCache;

private _bridges = [] call VIC_fnc_findBridges;
["STALKER_bridges", _bridges] call VIC_fnc_saveCache;

private _crossroads = [] call VIC_fnc_findCrossroads;
["STALKER_crossroads", _crossroads] call VIC_fnc_saveCache;

private _bClusters = [] call VIC_fnc_findBuildingClusters;
["STALKER_buildingClusters", _bClusters] call VIC_fnc_saveCache;

private _wreckPositions = [] call VIC_fnc_findWrecks;
["STALKER_wreckPositions", _wreckPositions] call VIC_fnc_saveCache;

"Map points regenerated" remoteExec ["hint", 0];

true
