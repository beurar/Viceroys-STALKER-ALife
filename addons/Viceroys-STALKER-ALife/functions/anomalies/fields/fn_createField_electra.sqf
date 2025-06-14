/*
    Creates an electra anomaly field.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER (optional) - anomaly count (default 5)
    Returns: ARRAY - spawned anomalies
*/
params ["_center","_radius", ["_count",5], ["_site", []]];
["fn_createField_electra"] call VIC_fnc_debugLog;

if (_site isEqualTo []) then {
    _site = [_center,_radius] call VIC_fnc_findSite_electra;
    if (_site isEqualTo []) exitWith {
        ["createField_electra: no site"] call VIC_fnc_debugLog;
        []
    };
} else {
    [format ["createField_electra: using site %1", _site]] call VIC_fnc_debugLog;
};
_site = [_site] call VIC_fnc_findLandPosition;
if (_site isEqualTo []) exitWith {
    ["createField_electra: land position failed"] call VIC_fnc_debugLog;
    []
};

// Create a marker for this anomaly field
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _markerName = format ["anom_electra_%1", diag_tickTime];
private _marker = [_markerName, _site, "ELLIPSE", "", "ColorBlue", 1, "Electra 30m"] call VIC_fnc_createGlobalMarker;
_marker setMarkerSize [30,30];
STALKER_anomalyMarkers pushBack _marker;

private _spawned = [];
for "_i" from 1 to _count do {
    private _off = [_site, random 30, random 360] call BIS_fnc_relPos;
    private _surf = [_off] call VIC_fnc_getLandSurfacePosition;
    if (_surf isEqualTo []) then { continue };
    private _anom = [_surf] call diwako_anomalies_main_fnc_createElectra;
    _anom setVariable ["zoneMarker", _marker];
    _spawned pushBack _anom;
};
[format ["createField_electra spawned %1", count _spawned]] call VIC_fnc_debugLog;
_spawned
