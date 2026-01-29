/*
    Samples a grid around the given center and returns the lowest
    land surface position found. This biases placement toward valleys.
    Params:
        0: ARRAY or OBJECT - center position
        1: NUMBER - search radius (default 50)
        2: NUMBER - grid step (default 10)
    Returns:
        ARRAY - position ASL of the lowest point or [] if none found
*/
params ["_center", ["_radius",50], ["_step",10]];

["findValleyPosition"] call VIC_fnc_debugLog;

private _debug = ["VSA_debugMode", false] call VIC_fnc_getSetting;
if (_debug && {isServer}) then {
    if (isNil "STALKER_valleySearchMarkers") then { STALKER_valleySearchMarkers = [] };
    { if (_x != "") then { deleteMarker _x } } forEach STALKER_valleySearchMarkers;
    STALKER_valleySearchMarkers = [];
};

private _base = if (_center isEqualType objNull) then { getPos _center } else { _center };
private _bestPos = [];
private _bestHeight = 1e9;

for "_xOff" from -_radius to _radius step _step do {
    for "_yOff" from -_radius to _radius step _step do {
        private _p = [(_base select 0) + _xOff, (_base select 1) + _yOff];
        private _surf = [_p] call VIC_fnc_getLandSurfacePosition;
        if (_surf isEqualTo []) then { continue };
        private _h = _surf select 2;
        if (_h < _bestHeight) then {
            _bestPos = _surf;
            _bestHeight = _h;
        };
    };
};

if (_debug && {isServer && { !(_bestPos isEqualTo []) }}) then {
    private _name = format ["valleyPos_%1", diag_tickTime + random 1000];
    private _m = [_name, ASLToAGL _bestPos, "ICON", "mil_arrow", VIC_colorGasYellow] call VIC_fnc_createGlobalMarker;
    STALKER_valleySearchMarkers pushBack _m;
};

_bestPos
