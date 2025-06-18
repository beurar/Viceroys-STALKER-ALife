/*
    Creates a clicker anomaly field.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER (optional) - anomaly count (default 5)
        3: ARRAY (optional) - site position to use (must be valid when provided)
    Returns: ARRAY - spawned anomalies
*/
params ["_center","_radius", ["_count",5], ["_site", []]];
["fn_createField_clicker"] call VIC_fnc_debugLog;

if (isNil {_site} || {_site isEqualTo []}) then {
    _site = [_center,_radius] call VIC_fnc_findSite_clicker;
    if (_site isEqualTo []) exitWith {
        ["createField_clicker: no site"] call VIC_fnc_debugLog;
        []
    };
} else {
    [format ["createField_clicker: using site %1", _site]] call VIC_fnc_debugLog;
};
_site = [_site] call VIC_fnc_findLandPosition;
if (_site isEqualTo []) exitWith {
    ["createField_clicker: land position failed"] call VIC_fnc_debugLog;
    []
};

// Create a marker for this anomaly field
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _markerName = format ["anom_clicker_%1", diag_tickTime];
private _marker = [_markerName, _site, "ELLIPSE", "", "ColorPink", 1, "Clicker 30m"] call VIC_fnc_createGlobalMarker;
_marker setMarkerSize [30,30];
STALKER_anomalyMarkers pushBack _marker;

private _spawned = [];
for "_i" from 1 to _count do {
    private _off = [_site, random 30, random 360] call BIS_fnc_relPos;
    private _surf = [_off] call VIC_fnc_getLandSurfacePosition;
    if (_surf isEqualTo []) then { continue };
    private _create = missionNamespace getVariable ["diwako_anomalies_main_fnc_createClicker", {}];
    if (_create isEqualTo {}) then {
        ["createField_clicker: Diwako Anomalies missing"] call VIC_fnc_debugLog;
        continue;
    };
    private _anom = [_surf] call _create;
    _anom setVariable ["zoneMarker", _marker];
    _spawned pushBack _anom;
};
[format ["createField_clicker spawned %1", count _spawned]] call VIC_fnc_debugLog;
_spawned
