/*
    Finds a location for electra anomaly fields near structures.
    Params:
        0: POSITION or OBJECT - center
        1: NUMBER - radius
    Returns: ARRAY - position
*/
params ["_center","_radius"];

private _posCenter = if (_center isEqualType objNull) then { getPos _center } else { _center };
private _sites = selectBestPlaces [_posCenter, _radius, "houses", 1, 25];
if (_sites isEqualTo []) exitWith { [] };
(_sites select 0) select 0
