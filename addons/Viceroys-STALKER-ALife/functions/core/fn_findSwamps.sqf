/*
    Identifies swamp-like regions based on terrain, water, and vegetation density.

    Params:
        0: SCALAR - Grid step for scanning (default: 300m)
        1: SCALAR - Elevation threshold (max height in meters, default: 3)
        2: SCALAR - Minimum number of bushes (default: 10)
        3: SCALAR - Radius to check vegetation (default: 30m)

    Returns:
        ARRAY of POSITIONs - Swamp center positions
*/

params [["_step", 300], ["_maxElevation", 3], ["_minBushes", 10], ["_radius", 30]];

["findSwamps"] call VIC_fnc_debugLog;

private _swamps = [];

for "_x" from 0 to worldSize step _step do {
    for "_y" from 0 to worldSize step _step do {
        private _pos = [_x, _y, 0];
        private _elev = getTerrainHeightASL _pos;

        // Skip high or dry zones
        if (_elev > _maxElevation) then { continue; };

        // Needs to be wet-ish but not submerged
        if (!([_pos] call VIC_fnc_isWaterPosition)) then { continue; };

        // Count bushes nearby (reeds, low growth)
        private _nearVeg = _pos nearObjects ["All", _radius];
        private _bushes = _nearVeg select {
            private _type = typeOf _x;
            (_type find "Bush" > -1 || _type find "Reed" > -1)
        };

        if ((count _bushes) >= _minBushes) then {
            _swamps pushBack _pos;
        };
    };
};

_swamps
