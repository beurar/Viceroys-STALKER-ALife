/*
    Finds an exposed flat area for whirligig anomaly fields.
    Params:
        0: POSITION or OBJECT - center
        1: NUMBER - radius
    Returns: ARRAY - position
*/
params ["_center","_radius"];
["fn_findSite_whirligig"] call VIC_fnc_debugLog;

private _posCenter = if (_center isEqualType objNull) then { getPos _center } else { _center };

// Pick a random land position within the search radius
private _site = [_posCenter, _radius, 10] call VIC_fnc_findLandPos;
if (isNil {_site} || {count _site == 0}) then { [] };
_site
