/*
    Places tripwires and booby traps inside random town buildings.
    Params:
        0: POSITION - center position
        1: NUMBER   - search radius (default 500)
        2: NUMBER   - trap count (optional)
    Returns:
        BOOL
*/
params ["_center", ["_radius",500], ["_count",-1]];

["spawnBoobyTraps"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

if (["VSA_enableBoobyTraps", true] call VIC_fnc_getSetting isEqualTo false) exitWith { false };

if (_count < 0) then { _count = ["VSA_boobyTrapCount",5] call VIC_fnc_getSetting; };

private _towns = nearestLocations [_center, ["NameVillage","NameCity","NameCityCapital","NameLocal"], _radius];

if (_towns isEqualTo []) exitWith { false };

if (isNil "STALKER_boobyTraps") then { STALKER_boobyTraps = [] };

private _spawned = 0;

for "_i" from 1 to _count do {
    if (_towns isEqualTo []) exitWith {};
    private _town = selectRandom _towns;
    private _tPos = locationPosition _town;
    private _buildings = nearestObjects [_tPos, ["House"], 150];
    if (_buildings isEqualTo []) then { continue; };

    private _bld = selectRandom _buildings;
    private _positions = [_bld] call BIS_fnc_buildingPositions;
    if (_positions isEqualTo []) then { continue; };

    private _pos = selectRandom _positions;
    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        _marker = format ["trap_%1", diag_tickTime + _i];
        [_marker, _pos, "ICON", "mil_triangle", "#(1,0.5,0,1)", 0.2, "Trap"] call VIC_fnc_createGlobalMarker;
    };

    private _anchor = [_pos] call VIC_fnc_createProximityAnchor;

    STALKER_boobyTraps pushBack [_pos, _anchor, [], _marker, false];
    _spawned = _spawned + 1;
};

[format ["spawnBoobyTraps: placed %1 traps", _spawned]] call VIC_fnc_debugLog;

true
