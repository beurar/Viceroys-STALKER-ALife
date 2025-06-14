/*
    Identifies swamp-like areas by scanning the entire map for shallow water
    with dense vegetation.

    Params:
        0: SCALAR - Grid step in meters (default: 100)
        1: SCALAR - Maximum water depth considered (default: 2)
        2: SCALAR - Minimum vegetation objects required (default: 5)
        3: SCALAR - Radius used to count vegetation (default: 25)

    Returns:
        ARRAY of POSITIONs - Swamp center positions
*/

params [["_step", 100], ["_maxDepth", 2], ["_minVeg", 5], ["_radius", 25]];

["findSwamps"] call VIC_fnc_debugLog;

private _swamps = [];

for "_x" from 0 to worldSize step _step do {
    for "_y" from 0 to worldSize step _step do {
        private _pos = [_x, _y, 0];
        if ([_pos] call VIC_fnc_isWaterPosition) then {
            private _depth = abs (getTerrainHeightASL _pos);
            if (_depth <= _maxDepth) then {
                private _veg = nearestTerrainObjects [_pos, ["BUSH","REED","SMALL TREE","TREE"], _radius, false];
                if ((count _veg) >= _minVeg) then {
                    _swamps pushBack _pos;
                };
            };
        };
    };
};

_swamps
