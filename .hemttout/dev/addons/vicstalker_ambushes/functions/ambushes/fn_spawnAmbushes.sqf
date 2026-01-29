/*
    Spawns ambush sites at road positions just outside towns.
    Params:
        0: POSITION - center position
        1: NUMBER   - search radius (default 500)
        2: NUMBER   - ambush count (optional)
*/
params ["_center", ["_radius",500], ["_count",-1]];

["spawnAmbushes"] call VIC_fnc_debugLog;

if (!isServer) exitWith {
    ["spawnAmbushes: server only"] call VIC_fnc_debugLog;
};

if (["VSA_enableAmbushes", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["spawnAmbushes: disabled"] call VIC_fnc_debugLog;
};

if (isNil "STALKER_ambushes") then { STALKER_ambushes = []; };

if (_count < 0) then { _count = ["VSA_ambushCount", 3] call VIC_fnc_getSetting; };

private _townRadius = ["VSA_townRadius", 500] call VIC_fnc_getSetting;
private _bandDist  = ["VSA_ambushTownDistance", 200] call VIC_fnc_getSetting;
private _outerRadius = _townRadius + _bandDist;

for "_i" from 1 to _count do {
    private _pos = nil;

    for "_j" from 1 to 30 do {
        private _candidate = [_center, _radius, 5] call VIC_fnc_findRoadPosition;

        private _locations = nearestLocations [
            _candidate,
            ["NameVillage","NameCity","NameCityCapital","NameLocal"],
            _outerRadius
        ];
        if (_locations isEqualTo []) then { continue; };

        private _loc = _locations select 0;
        private _dist = _candidate distance2D (locationPosition _loc);
        if (_dist > _townRadius && { _dist <= _outerRadius }) exitWith { _pos = _candidate };
    };
    if (isNil {_pos}) then { continue; };

    private _anchor = [_pos] call VIC_fnc_createProximityAnchor;

    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        _marker = format ["amb_%1", diag_tickTime + _i];
        [_marker, _pos, "ICON", "mil_ambush", "#(0.1,0.1,0.1,1)", 0.2, "Ambush"] call VIC_fnc_createGlobalMarker;
    };

    STALKER_ambushes pushBack [_pos, _anchor, objNull, [], [], false, _marker, false];
};

true;
