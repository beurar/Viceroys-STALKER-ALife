/*
    Author: STALKER ALife Script
    Description:
        Spawns a set of Drongo's spook zones using locations gathered by
        fn_setupSpookZones.sqf. Zone counts and behaviour are configured via
        CBA settings:
          - VSA_enableSpooks
          - VSA_spookZoneCount
          - VSA_spookSpawnWeight
          - VSA_spooksNightOnly
          - STALKER_SpookDuration controls lifetime
*/

["spawnSpookZone"] call VIC_fnc_debugLog;

if (isNil "drg_spook_zone_positions") then {
    [] call compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\spooks\fn_setupSpookZones.sqf";
};

if (["VSA_enableSpooks", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

private _count = ["VSA_spookZoneCount", 1] call VIC_fnc_getSetting;
private _weight = ["VSA_spookSpawnWeight", 50] call VIC_fnc_getSetting;
private _nightOnly = ["VSA_spooksNightOnly", true] call VIC_fnc_getSetting;
private _duration = missionNamespace getVariable ["STALKER_SpookDuration",15];

private _spookConfigs = [
    ["DSA_Abomination","VSA_abominationSpawnWeight","VSA_abominationCount","VSA_abominationTime"]
];

if (_nightOnly && {dayTime > 5 && dayTime < 20}) exitWith {};

if (isNil "drg_activeSpookZones") then { drg_activeSpookZones = []; };
if (isNil "STALKER_activeSpooks") then { STALKER_activeSpooks = []; };

for "_i" from 1 to _count do {
    if (random 100 >= _weight) then { continue };
    private _pos = selectRandom drg_spook_zone_positions;
    if (isNil {_pos}) then { continue };

    private _pool = [];
    private _isDay = (dayTime > 5 && dayTime < 20);
    {
        _x params ["_class","_wSetting","_cSetting","_tSetting"];
        private _w = [_wSetting,0] call VIC_fnc_getSetting;
        private _c = [_cSetting,1] call VIC_fnc_getSetting;
        private _t = [_tSetting,0] call VIC_fnc_getSetting;
        if (_t == 1 && _isDay) exitWith {};
        if (_t == 2 && !_isDay) exitWith {};
        if (_w > 0 && _c > 0) then { _pool pushBack [_class,_w,_c]; };
    } forEach _spookConfigs;

    if (_pool isEqualTo []) then { continue };
    private _total = 0;
    { _total = _total + (_x select 1); } forEach _pool;
    private _pick = random _total;
    private _choice = _pool select 0;
    {
        _pick = _pick - (_x select 1);
        if (_pick <= 0) exitWith { _choice = _x; };
    } forEach _pool;
    _choice params ["_class","_w","_num"];

    private _zone = createTrigger ["EmptyDetector", _pos];
    _zone setTriggerArea [25,25,0,false];
    _zone setVariable ["isSpookZone", true];

    private _spawned = [];
    for "_j" from 1 to _num do {
        private _s = createVehicle [_class, _pos, [], 0, "NONE"];
        _spawned pushBack _s;
        STALKER_activeSpooks pushBack _s;
    };
    _zone setVariable ["spawnedSpooks", _spawned];
    _zone setVariable ["VIC_active", true];

    private _markerName = format ["spook_%1", diag_tickTime];
    private _marker = _markerName;
    [_marker, _pos, "ELLIPSE", "", "#(0.2,0.2,0.2,1)", 1, format ["%1 x%2", _class select [4], _num]] call VIC_fnc_createGlobalMarker;
    [_marker, [25,25]] remoteExec ["setMarkerSize", 0];
    _zone setVariable ["zoneMarker", _marker];
    private _range = missionNamespace getVariable ["STALKER_activityRadius", 1500];

    [_zone, _marker, _range] spawn {
        params ["_zone","_marker","_range"];
        while {alive _zone} do {
            private _near = [getPosATL _zone, _range] call VIC_fnc_hasPlayersNearby;
            _marker setMarkerAlpha ([0.2, 1] select _near);
            sleep 5;
        };
    };

    drg_activeSpookZones pushBack _zone;
    [_zone, _spawned, _duration, _marker] spawn {
        params ["_zone","_spooks","_dur","_marker"];
        sleep (_dur * 60);
        {
            if (!isNull _x) then {
                deleteVehicle _x;
                if (!isNil "STALKER_activeSpooks") then {
                    STALKER_activeSpooks = STALKER_activeSpooks - [_x];
                };
            };
        } forEach _spooks;
        if (!isNull _zone) then {
            deleteVehicle _zone;
        };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };
};
