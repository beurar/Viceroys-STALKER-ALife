/*
    Creates an electra anomaly field.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER (optional) - anomaly count (default 5)
    Returns: ARRAY - spawned anomalies
*/
params ["_center","_radius", ["_count",5]];

private _site = [_center,_radius] call VIC_fnc_findSite_electra;
if (_site isEqualTo []) exitWith { [] };

private _spawned = [];
for "_i" from 1 to _count do {
    private _pos = _site getPos [random 10, random 360];
    private _anom = [_pos, "electra"] call diwako_anomalies_fnc_spawnAnomaly;
    _spawned pushBack _anom;
};
_spawned
