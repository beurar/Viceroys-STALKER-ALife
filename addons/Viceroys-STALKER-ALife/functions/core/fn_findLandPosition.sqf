/*
    Finds a nearby land position using simple random sampling.
    Params:
        0: POSITION - center position
        1: NUMBER   - search radius (default 300)
        2: NUMBER   - max attempts (default 20)
    Returns:
        ARRAY - ground position AGL or nil if none found
*/
params ["_centerPos", ["_radius", 300], ["_maxTries", 20]];

private _attempt = 0;

while { _attempt < _maxTries } do {
    private _angle = random 360;
    private _dist  = random _radius;
    private _candidate = _centerPos vectorAdd [
        _dist * cos _angle,
        _dist * sin _angle,
        0
    ];

    private _surf = [_candidate] call VIC_fnc_getLandSurfacePosition;
    if !(_surf isEqualTo []) exitWith { ASLToAGL _surf };

    _attempt = _attempt + 1;
};

nil
