/*
    Finds clusters of buildings that are at least 1km away from any town (of any type) or named location.

    Params:
        0: SCALAR - Min number of buildings to count as a cluster (default: 3)
        1: SCALAR - Radius for detecting nearby buildings (default: 500m)
        2: SCALAR - Distance to avoid from towns (default: 1000m)
        3: SCALAR - Grid step for scanning (default: 500m)

    Returns:
        ARRAY of ARRAYs - Each subarray is a cluster of building POSITIONS
*/

params [
    ["_minBuildings", 3],
    // Ensure the cluster search radius is at least as large as the grid step so
    // that neighbouring cells overlap when scanning.
    ["_clusterRadius", 500],
    ["_townClearDist", 1000],
    ["_step", 500]
];

["findBuildingClusters"] call VIC_fnc_debugLog;

private _clusters = [];
// Include all relevant town location types
private _locations = nearestLocations [
    [worldSize / 2, worldSize / 2, 0],
    ["NameVillage", "NameCity", "NameCityCapital", "NameLocal"],
    worldSize
];

for "_px" from 0 to worldSize step _step do {
    for "_py" from 0 to worldSize step _step do {
        private _scanCenter = [_px, _py, 0];

        // Skip positions too close to a named location
        private _nearTown = false;
        {
            if (_scanCenter distance (locationPosition _x) < _townClearDist) exitWith { _nearTown = true };
        } forEach _locations;
        if (_nearTown) then { continue; };

        // Use whichever radius is larger to make sure adjacent grid cells
        // overlap when checking for nearby buildings.
        private _searchRadius = _clusterRadius max _step;
        private _nearBuildings = _scanCenter nearObjects ["House", _searchRadius];
        private _realBuildings = _nearBuildings select {
            !isObjectHidden _x &&
            { getModelInfo _x select 0 != "" } &&
            { alive _x }
        };

        if ((count _realBuildings) >= _minBuildings) then {
            _clusters pushBack (_realBuildings apply { getPosATL _x });
        };
    };
};

// Cache results for later use
if (isNil "STALKER_buildingClusters") then { STALKER_buildingClusters = [] };
{ STALKER_buildingClusters pushBackUnique _x } forEach _clusters;

[format ["findBuildingClusters: %1 cached", count STALKER_buildingClusters]] call VIC_fnc_debugLog;

_clusters
