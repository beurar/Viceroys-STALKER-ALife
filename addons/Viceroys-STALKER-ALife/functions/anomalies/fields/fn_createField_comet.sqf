/*
    Creates a comet anomaly field which follows a looping path.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER (optional) - anomaly count (-1 = random)
        3: ARRAY (optional) - site position to use (must be valid when provided)
    Returns: ARRAY - spawned anomaly triggers
*/
params ["_center","_radius", ["_count",-1], ["_site", []]];

["fn_createField_comet"] call VIC_fnc_debugLog;

if (isNil {_site} || {count _site == 0}) then {
    _site = [_center,_radius] call VIC_fnc_findSite_comet;
    if (count _site == 0) exitWith {
        ["createField_comet: no site"] call VIC_fnc_debugLog;
        []
    };
} else {
    [format ["createField_comet: using site %1", _site]] call VIC_fnc_debugLog;
};
_site = [_site] call VIC_fnc_findLandPos;
if (isNil {_site} || {count _site == 0}) exitWith {
    ["createField_comet: land position failed"] call VIC_fnc_debugLog;
    []
};

if (_count < 0) then {
    private _max = ["VSA_anomaliesPerField", 40] call VIC_fnc_getSetting;
    _max = _max max 5;
    _count = floor (random (_max - 5 + 1)) + 5;
};

private _size = ["VSA_anomalyFieldRadius", 200] call VIC_fnc_getSetting;

// Create a marker for this anomaly field
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _markerName = format ["anom_comet_%1", diag_tickTime];
private _marker = [_markerName, _site, "ELLIPSE", "", "ColorOrange", 1, "Comet Path"] call VIC_fnc_createGlobalMarker;
_marker setMarkerSize [_size,_size];
STALKER_anomalyMarkers pushBack _marker;

private _create = missionNamespace getVariable ["diwako_anomalies_main_fnc_createComet", {}];
if (_create isEqualTo {}) exitWith {
    ["createField_comet: Diwako Anomalies missing"] call VIC_fnc_debugLog;
    []
};

private _spawned = [];
for "_i" from 1 to _count do {
    private _path = [];
    for "_j" from 0 to 3 do {
        private _off = [_site, 20 + random 10, _j * 90] call BIS_fnc_relPos;
        private _surf = [_off] call VIC_fnc_getLandSurfacePosition;
        if (_surf isEqualTo []) then { continue };

        // Create an invisible logic object for the waypoint so the comet has
        // an actual entity to follow.
        private _name = format ["comet_%1_%2", _i, _j];
        private _wp = "Logic" createVehicleLocal (ASLToATL _surf);
        _wp setVehicleVarName _name;
        missionNamespace setVariable [_name, _wp];

        _path pushBack _wp;
    };
    if (_path isEqualTo []) then { continue };
    private _anom = [_path] call _create;
    _anom setVariable ["zoneMarker", _marker];
    _spawned pushBack _anom;
};
[format ["createField_comet spawned %1", count _spawned]] call VIC_fnc_debugLog;
_spawned
