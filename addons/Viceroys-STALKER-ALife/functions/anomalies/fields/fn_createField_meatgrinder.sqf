/*
    Creates a meatgrinder anomaly field.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER (optional) - anomaly count (default 5)
    Returns: ARRAY - spawned anomalies
*/
params ["_center","_radius", ["_count",5], ["_site", []]];
["fn_createField_meatgrinder"] call VIC_fnc_debugLog;

if (_site isEqualTo []) then {
    _site = [_center,_radius] call VIC_fnc_findSite_meatgrinder;
};
if (_site isEqualTo []) exitWith { [] };

// Create a marker for this anomaly field
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _markerName = format ["anom_meatgrinder_%1", diag_tickTime];
private _marker = createMarker [_markerName, _site];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [10,10];
// Meatgrinder zones use a red marker
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Meatgrinder 10m";
STALKER_anomalyMarkers pushBack _marker;

private _spawned = [];
for "_i" from 1 to _count do {
    private _off = [_site, random 10, random 360] call BIS_fnc_relPos;
    private _surf = [_off] call VIC_fnc_getSurfacePosition;
    private _anom = [_surf] call diwako_anomalies_main_fnc_createMeatgrinder;
    _anom setVariable ["zoneMarker", _marker];
    _spawned pushBack _anom;
};
_spawned
