/*
    Selects a suitable location for burner anomaly fields.
    Params:
        0: POSITION or OBJECT - center of the search area
        1: NUMBER - search radius
    Returns: ARRAY - position of the chosen site
*/
params ["_center", "_radius"];

private _posCenter = if (_center isEqualType objNull) then { getPos _center } else { _center };

private _sites = selectBestPlaces [_posCenter, _radius, "(1 - forest - houses)", 1, 25];

if (_sites isEqualTo []) exitWith { [] };
(_sites select 0) select 0
