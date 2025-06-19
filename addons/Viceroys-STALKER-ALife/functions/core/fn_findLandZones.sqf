/*
    Finds mostly evenly distributed land positions across the map using a grid search.
    Each grid cell tries to locate one valid land position using
    VIC_fnc_findLandPosition.

    Params:
        0: NUMBER - grid step size in meters (default: 1000)
        1: BOOL   - exclude towns when sampling (default: true)

    Returns:
        ARRAY of POSITIONs - Land positions in AGL coordinates
*/
params [["_step", 1000], ["_excludeTowns", true]];

["findLandZones"] call VIC_fnc_debugLog;

private _zones = [];
private _half = _step / 2;

for "_x" from 0 to worldSize step _step do {
    for "_y" from 0 to worldSize step _step do {
        private _center = [_x + _half, _y + _half, 0];
        private _pos = [_center, _half, 10, _excludeTowns, _half] call
            VIC_fnc_findLandPosition;
        if (isNil {_pos}) then { _pos = [] };
        if !(_pos isEqualTo []) then {
            _zones pushBack _pos;
        };
    };
};

// Cache results for later use
if (isNil "STALKER_landZones") then { STALKER_landZones = [] };
{ STALKER_landZones pushBackUnique _x } forEach _zones;

_zones
