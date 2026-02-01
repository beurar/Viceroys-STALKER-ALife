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

        private _waterNearby = false;
        private _depthOk = false;

        // Check the current grid position first
        if ([_pos] call VIC_fnc_isWaterPosition) then {
            _waterNearby = true;
            if ((abs (getTerrainHeightASL _pos)) <= _maxDepth) then {
                _depthOk = true;
            };
        } else {
            // Sample neighboring grid positions for water
            {
                private _dir = _x;
                private _test = [_pos, _step / 2, _dir] call BIS_fnc_relPos;
                if ([_test] call VIC_fnc_isWaterPosition) exitWith {
                    _waterNearby = true;
                    if ((abs (getTerrainHeightASL _test)) <= _maxDepth) then {
                        _depthOk = true;
                    };
                };
            } forEach [0,45,90,135,180,225,270,315];
        };

        if (_waterNearby && _depthOk) then {
            private _veg = nearestTerrainObjects [_pos, ["BUSH","REED","SMALL TREE","TREE"], _radius, false];
            if ((count _veg) >= _minVeg) then {
                _swamps pushBack _pos;
            };
        };
    };
};

// Cache results for later use
if (isNil "STALKER_swamps") then { STALKER_swamps = [] };
{ STALKER_swamps pushBackUnique _x } forEach _swamps;

_swamps

