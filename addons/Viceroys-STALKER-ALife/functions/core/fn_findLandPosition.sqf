/*
    Attempts to find a nearby land position around the given center.
    Params:
        0: ARRAY or OBJECT - center position
        1: NUMBER - search radius (default 50)
        2: NUMBER - maximum attempts (default 10)
    Returns:
        ARRAY - land position or [] if none found
*/
params ["_center", ["_radius",50], ["_attempts",10]];

private _base = if (_center isEqualType objNull) then { getPos _center } else { _center };

for "_i" from 0 to _attempts do {
    private _candidate = if (_i == 0) then { _base } else { [_base, random _radius, random 360] call BIS_fnc_relPos };
    if (!([_candidate] call VIC_fnc_isWaterPosition)) exitWith { _candidate };
};
[]
