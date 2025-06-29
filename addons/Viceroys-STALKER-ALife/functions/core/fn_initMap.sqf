/*
    Caches all map positions required by STALKER ALife systems.
*/


["initMap"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

// Load cached data when available to avoid expensive scans
private _roads = ["STALKER_roads"] call VIC_fnc_loadCache;
if (isNil {_roads} || {_roads isEqualTo []}) then {
    _roads = [] call VIC_fnc_findRoads;
    ["STALKER_roads", _roads] call VIC_fnc_saveCache;
};

// Land zones are optional but load if present
private _zones = ["STALKER_landZones"] call VIC_fnc_loadCache;
if (!isNil {_zones} && {_zones isEqualType [] && {count _zones == 0}}) then {
    _zones = [] call VIC_fnc_findLandZones;
    ["STALKER_landZones", _zones] call VIC_fnc_saveCache;
};

private _rockClusters = ["STALKER_rockClusters"] call VIC_fnc_loadCache;
if (isNil {_rockClusters} || {_rockClusters isEqualTo []}) then {
    _rockClusters = [] call VIC_fnc_findRockClusters;
    ["STALKER_rockClusters", _rockClusters] call VIC_fnc_saveCache;
};

private _sniperSpots = ["STALKER_sniperSpots"] call VIC_fnc_loadCache;
if (isNil {_sniperSpots} || {_sniperSpots isEqualTo []}) then {
    _sniperSpots = [] call VIC_fnc_findSniperSpots;
    ["STALKER_sniperSpots", _sniperSpots] call VIC_fnc_saveCache;
};

private _swamps = ["STALKER_swamps"] call VIC_fnc_loadCache;
if (isNil {_swamps} || {_swamps isEqualTo []}) then {
    _swamps = [] call VIC_fnc_findSwamps;
    ["STALKER_swamps", _swamps] call VIC_fnc_saveCache;
};

private _beaches = ["STALKER_beachSpots"] call VIC_fnc_loadCache;
if (isNil {_beaches} || {_beaches isEqualTo []}) then {
    _beaches = [] call VIC_fnc_findBeachesInMap;
    ["STALKER_beachSpots", _beaches] call VIC_fnc_saveCache;
};

private _valleys = ["STALKER_valleys"] call VIC_fnc_loadCache;
if (isNil {_valleys} || {_valleys isEqualTo []}) then {
    _valleys = [] call VIC_fnc_findValleys;
    ["STALKER_valleys", _valleys] call VIC_fnc_saveCache;
};

private _bridges = ["STALKER_bridges"] call VIC_fnc_loadCache;
if (isNil {_bridges} || {_bridges isEqualTo []}) then {
    _bridges = [] call VIC_fnc_findBridges;
    ["STALKER_bridges", _bridges] call VIC_fnc_saveCache;
};

private _crossroads = ["STALKER_crossroads"] call VIC_fnc_loadCache;
if (isNil {_crossroads} || {_crossroads isEqualTo []}) then {
    _crossroads = [] call VIC_fnc_findCrossroads;
    ["STALKER_crossroads", _crossroads] call VIC_fnc_saveCache;
};

private _bClusters = ["STALKER_buildingClusters"] call VIC_fnc_loadCache;
if (isNil {_bClusters} || {_bClusters isEqualTo []}) then {
    _bClusters = [] call VIC_fnc_findBuildingClusters;
    ["STALKER_buildingClusters", _bClusters] call VIC_fnc_saveCache;
};

private _wrecks = ["STALKER_wrecks"] call VIC_fnc_loadCache;
if (isNil {_wrecks} || {_wrecks isEqualTo []}) then {
    _wrecks = [] call VIC_fnc_findWrecks;
    ["STALKER_wrecks", _wrecks] call VIC_fnc_saveCache;
};

// Load or generate mutant habitats
private _habData = ["STALKER_mutantHabitatData"] call VIC_fnc_loadCache;
if (isNil {_habData} || {_habData isEqualTo []}) then {
    [] call VIC_fnc_setupMutantHabitats;
    _habData = missionNamespace getVariable ["STALKER_mutantHabitatData", []];
    ["STALKER_mutantHabitatData", _habData] call VIC_fnc_saveCache;
} else {
    [_habData] call VIC_fnc_spawnCachedHabitats;
};

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
