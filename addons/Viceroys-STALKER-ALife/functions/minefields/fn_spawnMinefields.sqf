/*
    Spawns APERS minefields and IEDs around a center position using CBA settings.
    Params:
        0: POSITION - center of the area
        1: NUMBER   - search radius (default 500)
        2: NUMBER   - APERS field count (optional)
        3: NUMBER   - IED count (optional)
*/
params ["_center", ["_radius",500], ["_fieldCount",-1], ["_iedCount",-1]];

["spawnMinefields"] call VIC_fnc_debugLog;

if (!isServer) exitWith {
    ["spawnMinefields: server only"] call VIC_fnc_debugLog;
};

if (["VSA_enableMinefields", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["spawnMinefields: disabled"] call VIC_fnc_debugLog;
};

if (isNil "STALKER_minefields") then { STALKER_minefields = []; };

if (_fieldCount < 0) then { _fieldCount = ["VSA_minefieldCount",2] call VIC_fnc_getSetting; };
if (_iedCount < 0) then { _iedCount = ["VSA_IEDCount",2] call VIC_fnc_getSetting; };
private _size = ["VSA_minefieldSize",30] call VIC_fnc_getSetting;

private _fieldsSpawned = 0;
private _iedsSpawned = 0;

private _towns = nearestLocations [_center, ["NameVillage","NameCity","NameCityCapital","NameLocal"], _radius];

private _useFallback = _towns isEqualTo [];
if (_useFallback) then {
    [format ["spawnMinefields: no towns found near %1 - using road fallback", _center]] call VIC_fnc_debugLog;
};

for "_i" from 1 to _fieldCount do {
    private _pos = [];
    if (_useFallback) then {
        _pos = [_center, _radius, 20] call VIC_fnc_findRoadPosition;
        if (isNil {_pos}) then { _pos = [_radius, 20] call VIC_fnc_findRandomRoadPosition; };
    } else {
        private _town = selectRandom _towns;
        private _tPos = locationPosition _town;
        _pos = _tPos getPos [150 + random 200, random 360];
        _pos = [_pos] call VIC_fnc_findLandPos;
    };
    if (isNil {_pos} || { _pos isEqualTo [] }) then { continue; };

    private _anchor = [_pos] call VIC_fnc_createProximityAnchor;
    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        _marker = format ["mf_%1", diag_tickTime];
        [_marker, _pos, "ELLIPSE", "", "#(1,1,0,1)", 0.2, "APERS Field"] call VIC_fnc_createGlobalMarker;
        _marker setMarkerSize [_size, _size];
    };
    STALKER_minefields pushBack [_pos,_anchor,"APERS",_size,[],_marker,false];
    _fieldsSpawned = _fieldsSpawned + 1;
};

for "_i" from 1 to _iedCount do {
    private _pos = [];
    if (_useFallback) then {
        _pos = [_center, _radius, 20] call VIC_fnc_findRoadPosition;
        if (isNil {_pos}) then { _pos = [_radius, 20] call VIC_fnc_findRandomRoadPosition; };
    } else {
        private _town = selectRandom _towns;
        private _tPos = locationPosition _town;
        _pos = [_tPos, 200, 10] call VIC_fnc_findRoadPosition;
    };
    if (isNil {_pos}) then { continue; };

    private _anchor = [_pos] call VIC_fnc_createProximityAnchor;
    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        _marker = format ["ied_%1", diag_tickTime];
        [_marker, _pos, "ICON", "mil_triangle", "#(0.9,0.2,0.2,1)", 0.2, "IED"] call VIC_fnc_createGlobalMarker;
    };
    STALKER_minefields pushBack [_pos,_anchor,"IED",0,[],_marker,false];
    _iedsSpawned = _iedsSpawned + 1;
};

if !(missionNamespace getVariable ["VIC_minefieldManagerRunning", false]) then {
    [] call VIC_fnc_startMinefieldManager;
};

[format ["spawnMinefields: placed %1 fields and %2 IEDs", _fieldsSpawned, _iedsSpawned]] call VIC_fnc_debugLog;

