/*
    Creates a whirligig anomaly field.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER (optional) - anomaly count (-1 = random)
        3: ARRAY (optional) - site position to use (must be valid when provided)
    Returns: ARRAY - spawned anomalies
*/
params ["_center","_radius", ["_count",-1], ["_site", []]];
["fn_createField_whirligig"] call VIC_fnc_debugLog;

if (isNil {_site} || {count _site == 0}) then {
    _site = [_center,_radius] call VIC_fnc_findSite_whirligig;
    if (count _site == 0) exitWith {
        ["createField_whirligig: no site"] call VIC_fnc_debugLog;
        []
    };
} else {
    [format ["createField_whirligig: using site %1", _site]] call VIC_fnc_debugLog;
};
_site = [_site] call VIC_fnc_findLandPos;
if (isNil {_site} || {count _site == 0}) exitWith {
    ["createField_whirligig: land position failed"] call VIC_fnc_debugLog;
    []
};

if (_count < 0) then {
    private _max = ["VSA_anomaliesPerField", 40] call VIC_fnc_getSetting;
    _max = _max max 5;
    _count = floor (random (_max - 5 + 1)) + 5;
    private _dens = ["VSA_anomalyDensity_Whirligig",100] call VIC_fnc_getSetting;
    _count = round (_count * (_dens / 100));
};

// Create a marker for this anomaly field
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _markerName = format ["anom_whirligig_%1", diag_tickTime];
private _size = ["VSA_anomalyFieldRadius", 200] call VIC_fnc_getSetting;
private _marker = [_markerName, _site, "ELLIPSE", "", VIC_colorTeleport, 1, format ["Whirligig %1m", _size]] call VIC_fnc_createGlobalMarker;
_marker setMarkerSizeLocal [_size,_size];
_marker setMarkerBrush "Border";
STALKER_anomalyMarkers pushBack _marker;

private _spawned = [];
for "_i" from 1 to _count do {
    private _off = [_site, random _size, random 360] call BIS_fnc_relPos;
    private _surf = [_off] call VIC_fnc_getLandSurfacePosition;
    if (_surf isEqualTo []) then { continue };
    private _create = missionNamespace getVariable ["diwako_anomalies_main_fnc_createWhirligig", {}];
    if (_create isEqualTo {}) then {
        ["createField_whirligig: Diwako Anomalies missing"] call VIC_fnc_debugLog;
        continue;
    };
    private _anom = [_surf] call _create;
    _anom setVariable ["zoneMarker", _marker];
    _spawned pushBack _anom;
};
[format ["createField_whirligig spawned %1", count _spawned]] call VIC_fnc_debugLog;
_spawned
