/*
    Scans the map for clusters of rock objects.

    Params:
        0: SCALAR - Minimum number of rocks in a cluster (default: 4)
        1: SCALAR - Cluster radius (default: 20 meters)
        2: SCALAR - (Unused, kept for backwards compatibility)

    Returns:
        ARRAY of ARRAYs - Each subarray is a cluster of rock OBJECTS
*/

params [["_minRocks", 4], ["_radius", 20], ["_step", 500]];
_step = _step; // parameter kept for backwards compatibility

["findRockClusters"] call VIC_fnc_debugLog;

private _rockClassnames = [
    "Land_Rock_01", "Land_Rock_01_F", "Land_Rock_01_4m_F", "Land_Rock_01_1m_F",
    "Land_Rock_02", "Land_Rock_02_F", "Land_Rock_02_4m_F", "Land_Rock_02_1m_F",
    "Land_Rock_WallH", "Land_Rock_WallV", "Land_Boulder_01_F",
    "Land_Boulder_02_F", "Land_Boulder_03_F", "Land_Stone_small_F",
    "Land_Stone_big_F", "Land_R_rock_general1", "Land_r_rock_general2"
];

private _allRocks = [];
{
    _allRocks append (
        nearestTerrainObjects [[worldSize / 2, worldSize / 2, 0], [_x], worldSize, false, true]
    );
} forEach _rockClassnames;

_allRocks = _allRocks arrayIntersect _allRocks; // Remove duplicates

private _clusters = [];
private _remaining = +_allRocks;

while {_remaining isNotEqualTo []} do {
    private _stack = [_remaining deleteAt 0];
    private _cluster = [];

    while {_stack isNotEqualTo []} do {
        private _rock = _stack deleteAt 0;
        if (_rock in _cluster) then { continue; };
        _cluster pushBack _rock;

        private _neighbors = nearestTerrainObjects [getPosATL _rock, _rockClassnames, _radius, false, true];
        {
            private _idx = _remaining find _x;
            if (_idx > -1) then {
                _stack pushBack _x;
                _remaining deleteAt _idx;
            };
        } forEach _neighbors;
    };

    if ((count _cluster) >= _minRocks) then {
        _clusters pushBack _cluster;
    };
};

// Cache results for later use
if (isNil "STALKER_rockClusters") then { STALKER_rockClusters = [] };
{ STALKER_rockClusters pushBackUnique _x } forEach _clusters;

_clusters
