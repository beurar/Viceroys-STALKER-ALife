/*
    Scans the map on a grid and records every midpoint between two adjacent
    grid cells where one is water and the other is land. These points represent
    potential beach locations along the shoreline.

    Params:
        0: NUMBER - grid step size in meters (default: 100)

    Returns:
        ARRAY of positions in AGL coordinates representing beach spots
*/
params [
    ["_step", 100],
    // Legacy parameters are ignored but kept for compatibility
    ["_maxDepth", 1],
    ["_vegRadius", 20],
    ["_vegThreshold", 2]
];

["fn_findBeachesInMap"] call VIC_fnc_debugLog;

// Variables kept for backwards compatibility
_maxDepth;
_vegRadius;
_vegThreshold;

private _spots = [];
private _size  = worldSize;

for "_x" from 0 to _size step _step do {
    for "_y" from 0 to _size step _step do {
        private _pos    = [_x, _y, 0];
        private _isWater = [_pos] call VIC_fnc_isWaterPosition;

        if (_x + _step <= _size) then {
            private _posE = [_x + _step, _y, 0];
            private _waterE = [_posE] call VIC_fnc_isWaterPosition;
            if (_isWater != _waterE) then {
                private _mid = [_x + (_step / 2), _y, 0];
                private _surf = [_mid] call VIC_fnc_getSurfacePosition;
                _spots pushBackUnique (ASLToAGL _surf);
            };
        };

        if (_y + _step <= _size) then {
            private _posN = [_x, _y + _step, 0];
            private _waterN = [_posN] call VIC_fnc_isWaterPosition;
            if (_isWater != _waterN) then {
                private _mid = [_x, _y + (_step / 2), 0];
                private _surf = [_mid] call VIC_fnc_getSurfacePosition;
                _spots pushBackUnique (ASLToAGL _surf);
            };
        };
    };
};

["fn_findBeachesInMap completed"] call VIC_fnc_debugLog;

// Cache results for later use
if (isNil "STALKER_beachSpots") then { STALKER_beachSpots = [] };
{ STALKER_beachSpots pushBackUnique _x } forEach _spots;

_spots

