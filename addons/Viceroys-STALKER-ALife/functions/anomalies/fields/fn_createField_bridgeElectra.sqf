/*
    Creates an electra anomaly field positioned on a bridge.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER - anomaly count (optional, default 5)
        3: ARRAY (optional) - site position to use (must be valid when provided)
    Returns: ARRAY - spawned anomalies
*/
params ["_center","_radius", ["_count",5], ["_site", []]];
["fn_createField_bridgeElectra"] call VIC_fnc_debugLog;

if (isNil {_site} || {count _site == 0}) then {
    _site = [_center,_radius] call VIC_fnc_findSite_bridge;
    if (count _site == 0) exitWith {
        ["createField_bridgeElectra: no site"] call VIC_fnc_debugLog;
        []
    };
} else {
    [format ["createField_bridgeElectra: using site %1", _site]] call VIC_fnc_debugLog;
};
_site = [_site] call VIC_fnc_findLandPos;
if (isNil {_site} || {count _site == 0}) exitWith {
    ["createField_bridgeElectra: land position failed"] call VIC_fnc_debugLog;
    []
};

private _size = ["VSA_anomalyFieldRadius", 200] call VIC_fnc_getSetting;

if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _markerName = format ["anom_bridge_%1", diag_tickTime];
private _marker = [_markerName, _site, "ELLIPSE", "", "ColorBlue", 1, format ["Bridge Electra %1m", _size]] call VIC_fnc_createGlobalMarker;
_marker setMarkerSize [_size,_size];
STALKER_anomalyMarkers pushBack _marker;

private _spawned = [];
for "_i" from 1 to _count do {
    private _off = [_site, random _size, random 360] call BIS_fnc_relPos;
    private _surf = [_off] call VIC_fnc_getLandSurfacePosition;
    if (_surf isEqualTo []) then { continue };
    private _create = missionNamespace getVariable ["diwako_anomalies_main_fnc_createElectra", {}];
    if (_create isEqualTo {}) then {
        ["createField_bridgeElectra: Diwako Anomalies missing"] call VIC_fnc_debugLog;
        continue;
    };
    private _anom = [_surf] call _create;
    _anom setVariable ["zoneMarker", _marker];
    _spawned pushBack _anom;
};
[format ["createField_bridgeElectra spawned %1", count _spawned]] call VIC_fnc_debugLog;
_spawned
