/*
    Creates a leech anomaly field.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER (optional) - anomaly count (default 5)
    Returns: ARRAY - spawned anomalies
*/
params ["_center","_radius", ["_count",5], ["_site", []]];
["fn_createField_leech"] call VIC_fnc_debugLog;

if (_site isEqualTo []) then {
    _site = [_center,_radius] call VIC_fnc_findSite_leech;
};
if (_site isEqualTo []) exitWith { [] };

// Create a marker for this anomaly field
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _markerName = format ["anom_leech_%1", diag_tickTime];
private _marker = createMarker [_markerName, _site];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [15,15];
_marker setMarkerColor "ColorBlack";
_marker setMarkerText "Leech 15m";
STALKER_anomalyMarkers pushBack _marker;

private _spawned = [];
for "_i" from 1 to _count do {
    private _off = [_site, random 15, random 360] call BIS_fnc_relPos;
    private _surf = [_off] call VIC_fnc_getSurfacePosition;
    private _anom = createVehicle ["DSA_Leech", ASLToATL _surf, [], 0, "NONE"];
    _anom setVariable ["zoneMarker", _marker];
    _spawned pushBack _anom;
};
_spawned
