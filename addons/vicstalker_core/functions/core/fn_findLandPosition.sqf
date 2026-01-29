/*
    Simplified wrapper that returns a land position using BIS_fnc_randomPos.
    The old expanding search logic has been removed.

    Params:
        0: POSITION or OBJECT - center position
        1: NUMBER            - search radius (default 50)
        2: NUMBER            - attempts (unused, kept for compatibility)
        3: BOOL              - exclude towns from results (default false)
        4: NUMBER            - maximum search radius (unused)

    Returns:
        ARRAY - ground position AGL or nil if none found
*/

params [
    "_centerPos",
    ["_radius", 50],
    ["_maxTries", 10],
    ["_excludeTowns", false],
    ["_maxRadius", -1]
];

private _dummy = [_maxTries, _maxRadius];
_dummy;

private _base = if (_centerPos isEqualType objNull) then { getPos _centerPos } else { _centerPos };

private _townRadius = ["VSA_townRadius", 500] call VIC_fnc_getSetting;

private _condition = if (_excludeTowns) then {
    {
        nearestLocations [_this, ["NameCity","NameVillage","NameCityCapital","NameLocal"], _townRadius] isEqualTo []
    }
} else {
    { true }
};

private _pos = [[[_base, _radius]], ["water"], _condition] call BIS_fnc_randomPos;
if ((_pos isEqualTo [0,0]) || { _pos isEqualTo [0,0,0] }) exitWith { nil };

private _px = _pos select 0;
private _py = _pos select 1;
if (_px < 0 || { _py < 0 } || { _px > worldSize } || { _py > worldSize }) exitWith { nil };

_pos
