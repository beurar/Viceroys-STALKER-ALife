/*
    Creates a fruitpunch anomaly field.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER (optional) - anomaly count (default 5)
    Returns: ARRAY - spawned anomalies
*/
params ["_center","_radius", ["_count",5]];
["fn_createField_fruitpunch"] call VIC_fnc_debugLog;

private _site = [_center,_radius] call VIC_fnc_findSite_fruitpunch;
if (_site isEqualTo []) exitWith { [] };

// Create a marker for this anomaly field
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _markerName = format ["anom_fruitpunch_%1", diag_tickTime];
private _marker = createMarker [_markerName, _site];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [10,10];
// Use green to distinguish fruit punch fields
_marker setMarkerColor "ColorGreen";
_marker setMarkerText "Fruitpunch 10m";
STALKER_anomalyMarkers pushBack _marker;

private _spawned = [];
for "_i" from 1 to _count do {
    private _pos = _site getPos [random 10, random 360];
    private _anom = [_pos] call diwako_anomalies_main_fnc_createFruitPunch;
    _anom setVariable ["zoneMarker", _marker];
    _spawned pushBack _anom;
};
_spawned
