/*
    Spawns ambush sites at road positions far from towns.
    Params:
        0: POSITION - center position
        1: NUMBER   - search radius (default 500)
        2: NUMBER   - ambush count (optional)
*/
params ["_center", ["_radius",500], ["_count",-1]];

["spawnAmbushes"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableAmbushes", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_ambushes") then { STALKER_ambushes = []; };

if (_count < 0) then { _count = ["VSA_ambushCount", 3] call VIC_fnc_getSetting; };

private _townDist = ["VSA_ambushTownDistance", 700] call VIC_fnc_getSetting;

for "_i" from 1 to _count do {
    private _pos = nil;

    for "_j" from 1 to 30 do {
        private _candidate = [_center, _radius, 5] call VIC_fnc_findRoadPosition;
        if (isNil "_candidate") then { continue; };

        private _locations = nearestLocations [
            _candidate,
            ["NameVillage","NameCity","NameCityCapital","NameLocal"],
            _townDist
        ];
        if (_locations isEqualTo []) exitWith { _pos = _candidate };
    };
    if (isNil "_pos") then { continue; };

    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        _marker = format ["amb_%1", diag_tickTime + _i];
        [_marker, _pos, "ICON", "mil_triangle", "ColorBlack", 0.2, "Ambush"] call VIC_fnc_createGlobalMarker;
    };

    STALKER_ambushes pushBack [_pos, objNull, [], [], false, _marker];
};

true;
