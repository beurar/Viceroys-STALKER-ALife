/*
    Finds a location on or near a bridge object.
    Params:
        0: POSITION or OBJECT - center position
        1: NUMBER - search radius
    Returns: ARRAY - position or [] if none found
*/
params ["_center","_radius"];
["fn_findSite_bridge"] call VIC_fnc_debugLog;

private _posCenter = if (_center isEqualType objNull) then { getPos _center } else { _center };

// Cache bridge objects for performance
private _bridges = missionNamespace getVariable ["VIC_cachedBridges", []];
if (_bridges isEqualTo []) then {
    _bridges = [] call VIC_fnc_findBridges;
    missionNamespace setVariable ["VIC_cachedBridges", _bridges];
};

private _candidates = _bridges select { _posCenter distance2D _x <= _radius };
if (_candidates isEqualTo []) then { [] };

private _bridge = selectRandom _candidates;
private _pos = getPosATL _bridge;
[_pos, 0, 10] call VIC_fnc_findLandPos
