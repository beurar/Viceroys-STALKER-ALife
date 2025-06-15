/*
    Finds a dense forest location for meatgrinder anomaly fields.
    Params:
        0: POSITION or OBJECT - center
        1: NUMBER - radius
    Returns: ARRAY - position
*/
params ["_center","_radius"];
["fn_findSite_meatgrinder"] call VIC_fnc_debugLog;

private _posCenter = if (_center isEqualType objNull) then { getPos _center } else { _center };

// Pick a random land position within the search radius
private _site = [_posCenter, _radius, 10, false] call VIC_fnc_findLandPosition;
if (_site isEqualTo []) exitWith { [] };
_site
