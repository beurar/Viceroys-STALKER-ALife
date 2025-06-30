/*
    Spawns multiple IED sites near a center position.
    Params:
        0: POSITION - center of the area
        1: NUMBER   - search radius (default 500)
        2: NUMBER   - number of IED sites (optional)
    Returns:
        BOOL
*/
params ["_center", ["_radius",500], ["_count",-1]];

// Avoid spamming the console when the manager frequently polls this
// function. Only log when we actually place at least one site.

if (!isServer) exitWith { false };

if (["VSA_enableMinefields", true] call VIC_fnc_getSetting isEqualTo false) exitWith { false };

if (isNil "STALKER_iedSites") then { STALKER_iedSites = [] };

private _spawned = 0;

if (_count < 0) then { _count = ["VSA_IEDSiteCount",10] call VIC_fnc_getSetting; };

private _towns = nearestLocations [_center, ["NameVillage","NameCity","NameCityCapital","NameLocal"], _radius];
private _useFallback = _towns isEqualTo [];

for "_i" from 1 to _count do {
    private _pos = [];
    if (_useFallback) then {
        _pos = [_center, _radius, 20] call VIC_fnc_findRoadPosition;
    } else {
        private _town = selectRandom _towns;
        private _tPos = locationPosition _town;
        _pos = [_tPos, 200, 10] call VIC_fnc_findRoadPosition;
    };
    if (isNil {_pos}) then { continue };

    [_pos] call VIC_fnc_createProximityAnchor;

    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        _marker = format ["ied_%1_%2", count STALKER_iedSites, diag_tickTime];
        [_marker, _pos, "ICON", "mil_triangle", "#(0.9,0.2,0.2,1)", 0.2, "IED"] call VIC_fnc_createGlobalMarker;
    };

    STALKER_iedSites pushBack [_pos, objNull, _marker, false];
    _spawned = _spawned + 1;
};

if (_spawned > 0) then {
    [format ["spawnIEDSites: placed %1 sites", _spawned]] call VIC_fnc_debugLog;
};

true
