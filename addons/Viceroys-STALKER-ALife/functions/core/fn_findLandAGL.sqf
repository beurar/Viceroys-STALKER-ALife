/*
    Wrapper for VIC_fnc_findLandASL that returns AGL coordinates.
    Params:
        0: ARRAY or OBJECT - center position
        1: NUMBER - search radius (default 50)
        2: NUMBER - maximum attempts (default 10)
        3: BOOL   - exclude towns from results (default false)
        4: NUMBER - maximum search radius (optional)
    Returns:
        ARRAY - ground position AGL or [] if none found
*/
params ["_center", ["_radius",50], ["_attempts",10], ["_excludeTowns", false], ["_maxRadius", -1]];

private _posASL = [_center,_radius,_attempts,_excludeTowns,_maxRadius] call VIC_fnc_findLandASL;
if (_posASL isEqualTo []) exitWith { [] };
ASLToAGL _posASL;
