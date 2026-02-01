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

// Building clusters are cached as arrays of positions
private _bClusterPositions = ["STALKER_buildingClusters"] call VIC_fnc_loadCache;
if (isNil {_bClusterPositions} || {_bClusterPositions isEqualTo []}) then {
    _bClusterPositions = [] call VIC_fnc_findBuildingClusters;
    ["STALKER_buildingClusters", _bClusterPositions] call VIC_fnc_saveCache;
}; 

private _wreckPositions = ["STALKER_wreckPositions"] call VIC_fnc_loadCache;
if (isNil {_wreckPositions} || {_wreckPositions isEqualTo []}) then {
    _wreckPositions = [] call VIC_fnc_findWrecks;
    ["STALKER_wreckPositions", _wreckPositions] call VIC_fnc_saveCache;
};
if (isNil "STALKER_wrecks") then { STALKER_wrecks = []; };
{
    private _near = nearestObjects [_x, ["AllVehicles","Static"], 5];
    {
        private _type = toLower typeOf _x;
        private _model = toLower ((getModelInfo _x) select 0);
        if (("wreck" in _type) || { "wrecks" in _model }) exitWith {
            STALKER_wrecks pushBackUnique _x;
        };
    } forEach _near;
} forEach _wreckPositions;

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
    // Marker autogeneration disabled in production. Use placeCachedMarkers for debugging.
};

"STALKER ALife initialization complete" remoteExec ["hint", 0];

true
