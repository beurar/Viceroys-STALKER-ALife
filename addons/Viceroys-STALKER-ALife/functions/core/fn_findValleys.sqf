/*
    Identifies valleys by scanning the terrain on a grid and expanding
    outwards from local depressions. The lowest point among the first
    three neighbours in all eight directions is used as the valley
    seed. From that seed the surrounding terrain is sampled using
    raycasts and positions of similar elevation are collected to form
    the valley contour.

    Params:
        0: SCALAR - grid step size in meters (default: 250)
        1: SCALAR - elevation threshold in meters considered part of a valley
                    relative to the lowest point (default: 15)
        2: SCALAR - maximum expansion radius in meters (default: 750)

    Returns:
        ARRAY of ARRAYs - each entry contains positions describing a valley
*/

params [["_step", 250], ["_depthThreshold", 15], ["_maxRadius", 750]];

["findValleys"] call VIC_fnc_debugLog;

private _valleys = [];
private _dirs = [0,45,90,135,180,225,270,315];

for "_gx" from 0 to worldSize step _step do {
    for "_gy" from 0 to worldSize step _step do {
        private _center = [_gx, _gy, 0];
        private _surfCenter = [_center] call VIC_fnc_getLandSurfacePosition;
        if (_surfCenter isEqualTo []) then { continue; };
        private _centerHeight = _surfCenter select 2;

        private _lowestPos = _center;
        private _lowestHeight = _centerHeight;
        private _highestHeight = _centerHeight;

        {
            private _d = _x;
            for "_r" from 1 to 3 do {
                private _pos = [_center, _r * _step, _d] call BIS_fnc_relPos;
                private _surf = [_pos] call VIC_fnc_getLandSurfacePosition;
                if (_surf isEqualTo []) then { continue; };
                private _h = _surf select 2;
                if (_h < _lowestHeight) then {
                    _lowestHeight = _h;
                    _lowestPos = ASLToAGL _surf;
                };
                _highestHeight = _highestHeight max _h;
            };
        } forEach _dirs;

        if ((_highestHeight - _lowestHeight) <= _depthThreshold) then { continue; };

        // breadth-first expansion from the lowest point to map the valley contour
        private _queue = [_lowestPos];
        private _visited = [];
        private _valley = [];

        while {count _queue > 0} do {
            private _p = _queue deleteAt 0;
            if (_p in _visited) then { continue; };
            _visited pushBack _p;

            private _surf = [_p] call VIC_fnc_getLandSurfacePosition;
            if (_surf isEqualTo []) then { continue; };
            private _h = _surf select 2;

            if ((_h - _lowestHeight) <= _depthThreshold && { _p distance2D _lowestPos <= _maxRadius }) then {
                _valley pushBack _p;
                {
                    private _d = _x;
                    private _n = [_p, _step, _d] call BIS_fnc_relPos;
                    _queue pushBackUnique _n;
                } forEach _dirs;
            };
        };

        if (count _valley > 0) then {
            _valleys pushBack _valley;
        };
    };
};

_valleys
