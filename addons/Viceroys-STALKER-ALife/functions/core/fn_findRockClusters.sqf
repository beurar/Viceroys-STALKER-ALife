/*
    Scans the map for clusters of rock objects.

    Params:
        0: SCALAR - Minimum number of rocks in a cluster (default: 4)
        1: SCALAR - Cluster radius (default: 20 meters)
        2: SCALAR - Grid step size (default: 500m)

    Returns:
        ARRAY of ARRAYs - Each subarray is a cluster of rock OBJECTS
*/

params [["_minRocks", 4], ["_radius", 20], ["_step", 500]];

["findRockClusters"] call VIC_fnc_debugLog;

private _rockClassnames = [
    "Land_Rock_01", "Land_Rock_01_F", "Land_Rock_01_4m_F", "Land_Rock_01_1m_F",
    "Land_Rock_02", "Land_Rock_02_F", "Land_Rock_02_4m_F", "Land_Rock_02_1m_F",
    "Land_Rock_WallH", "Land_Rock_WallV", "Land_Boulder_01_F",
    "Land_Boulder_02_F", "Land_Boulder_03_F", "Land_Stone_small_F",
    "Land_Stone_big_F", "Land_R_rock_general1", "Land_r_rock_general2"
];

private _clusters = [];

for "_x" from 0 to worldSize step _step do {
    for "_y" from 0 to worldSize step _step do {
        private _center = [_x, _y, 0];
        private _nearRocks = _center nearObjects ["All", _radius];

        private _rocks = _nearRocks select {
            (typeOf _x) in _rockClassnames
        };

        if ((count _rocks) >= _minRocks) then {
            _clusters pushBack _rocks;
        };
    };
};

_clusters
