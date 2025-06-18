/*
    Finds a location for clicker anomaly fields near light vegetation.
    Params:
        0: POSITION or OBJECT - center
        1: NUMBER - radius
    Returns: ARRAY - position
*/
params ["_center","_radius"];
["fn_findSite_clicker"] call VIC_fnc_debugLog;

private _posCenter = if (_center isEqualType objNull) then { getPos _center } else { _center };

// Pick a random land position within the search radius
private _site = [_posCenter, _radius, 10, false] call VIC_fnc_findLandPosition;
if (isNil {_site} || {_site isEqualTo []}) exitWith { [] };
_site
