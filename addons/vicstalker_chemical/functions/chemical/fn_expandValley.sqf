/*
    Performs a flood fill starting from a valley seed position to gather
    contiguous low points similar to the logic used by fn_findValleys.

    Params:
        0: POSITION - valley seed position (AGL)
        1: NUMBER - grid step size (default 50)
        2: NUMBER - elevation threshold relative to the lowest point (default 15)
        3: NUMBER - maximum expansion radius (default 500)

    Returns:
        ARRAY of POSITIONs forming the valley area
*/
params ["_start", ["_step",50], ["_depthThreshold",15], ["_maxRadius",500]];

private _surf = [_start] call VIC_fnc_getLandSurfacePosition;
if (_surf isEqualTo []) exitWith { [] };
private _lowestHeight = _surf select 2;

private _dirs = [0,45,90,135,180,225,270,315];
private _queue = [_start];
private _visited = [];
private _valley = [];

while {_queue isNotEqualTo []} do {
    private _p = _queue deleteAt 0;
    if (_p in _visited) then { continue; };
    _visited pushBack _p;

    private _s = [_p] call VIC_fnc_getLandSurfacePosition;
    if (_s isEqualTo []) then { continue; };
    private _h = _s select 2;

    if ((_h - _lowestHeight) <= _depthThreshold && { _p distance2D _start <= _maxRadius }) then {
        _valley pushBack _p;
        {
            private _d = _x;
            private _n = [_p, _step, _d] call BIS_fnc_relPos;
            _queue pushBackUnique _n;
        } forEach _dirs;
    };
};

_valley
