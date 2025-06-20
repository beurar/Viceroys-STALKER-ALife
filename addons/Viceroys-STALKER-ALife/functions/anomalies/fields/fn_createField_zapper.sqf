/*
    Creates a zapper anomaly field.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER (optional) - anomaly count (-1 = random)
        3: ARRAY (optional) - site position to use (must be valid when provided)
    Returns: ARRAY - spawned anomalies
*/
params ["_center","_radius", ["_count",-1], ["_site", []]];
["fn_createField_zapper"] call VIC_fnc_debugLog;

if (isNil {_site} || {count _site == 0}) then {
    _site = [_center,_radius] call VIC_fnc_findSite_zapper;
    if (count _site == 0) exitWith {
        ["createField_zapper: no site"] call VIC_fnc_debugLog;
        []
    };
} else {
    [format ["createField_zapper: using site %1", _site]] call VIC_fnc_debugLog;
};
_site = [_site] call VIC_fnc_findLandPos;
if (isNil {_site} || {count _site == 0}) exitWith {
    ["createField_zapper: land position failed"] call VIC_fnc_debugLog;
    []
};

if (_count < 0) then {
    private _max = ["VSA_anomaliesPerField", 40] call VIC_fnc_getSetting;
    _max = _max max 5;
    _count = floor (random (_max - 5 + 1)) + 5;
};

// Create a marker for this anomaly field
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _markerName = format ["anom_zapper_%1", diag_tickTime];
private _size = ["VSA_anomalyFieldRadius", 200] call VIC_fnc_getSetting;
private _marker = [_markerName, _site, "ELLIPSE", "", "ColorEAST", 1, format ["Zapper %1m", _size]] call VIC_fnc_createGlobalMarker;
_marker setMarkerSize [_size,_size];
STALKER_anomalyMarkers pushBack _marker;

private _spawned = [];
for "_i" from 1 to _count do {
    private _off = [_site, random _size, random 360] call BIS_fnc_relPos;
    private _surf = [_off] call VIC_fnc_getLandSurfacePosition;
    if (_surf isEqualTo []) then { continue };
    private _anom = createVehicle ["DSA_Zapper", ASLToATL _surf, [], 0, "NONE"];
    _anom setVariable ["zoneMarker", _marker];
    _spawned pushBack _anom;
};
[format ["createField_zapper spawned %1", count _spawned]] call VIC_fnc_debugLog;
_spawned
