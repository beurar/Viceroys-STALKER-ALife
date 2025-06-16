/*
    Scans the entire map on a grid to locate shallow water positions that touch
    land and have little nearby vegetation. These are considered potential
    beach sites.

    Params:
        0: NUMBER - grid step size in meters (default: 100)
        1: NUMBER - maximum water depth in meters to count as "shallow" (default: 1)
        2: NUMBER - radius to check for nearby vegetation (default: 20)
        3: NUMBER - maximum vegetation objects allowed within the radius (default: 2)

    Returns:
        ARRAY of positions in AGL coordinates representing beach spots
*/
params [
    ["_step", 100],
    ["_maxDepth", 1],
    ["_vegRadius", 20],
    ["_vegThreshold", 2]
];

["fn_findBeachesInMap"] call VIC_fnc_debugLog;

private _spots = [];

for "_xCoord" from 0 to worldSize step _step do {
    for "_yCoord" from 0 to worldSize step _step do {
        private _pos = [_xCoord, _yCoord, 0];
        if ([_pos] call VIC_fnc_isWaterPosition) then {
            private _depth = abs (getTerrainHeightASL _pos);
            if (_depth <= _maxDepth) then {
                private _landNearby = false;
                {
                    private _test = [_pos, _step, _x] call BIS_fnc_relPos;
                    if (!([_test] call VIC_fnc_isWaterPosition)) exitWith { _landNearby = true };
                } forEach [0, 90, 180, 270];
                if (_landNearby) then {
                    private _veg = nearestTerrainObjects [_pos, ["BUSH","REED","SMALL TREE","TREE"], _vegRadius, false];
                    if ((count _veg) <= _vegThreshold) then {
                        private _surf = [_pos] call VIC_fnc_getSurfacePosition;
                        _spots pushBack (ASLToAGL _surf);
                    };
                };
            };
        };
    };
}; 

["fn_findBeachesInMap completed"] call VIC_fnc_debugLog;

_spots
