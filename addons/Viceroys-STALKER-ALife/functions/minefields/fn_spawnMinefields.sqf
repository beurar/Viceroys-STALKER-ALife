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

if (!isServer) exitWith {};

if (["VSA_enableMinefields", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_minefields") then { STALKER_minefields = []; };

if (_fieldCount < 0) then { _fieldCount = ["VSA_minefieldCount",2] call VIC_fnc_getSetting; };
if (_iedCount < 0) then { _iedCount = ["VSA_IEDCount",2] call VIC_fnc_getSetting; };
private _size = ["VSA_minefieldSize",30] call VIC_fnc_getSetting;

private _towns = nearestLocations [_center, ["NameVillage","NameCity","NameCityCapital","NameLocal"], _radius];

for "_i" from 1 to _fieldCount do {
    if (_towns isEqualTo []) exitWith {};
    private _town = selectRandom _towns;
    private _tPos = locationPosition _town;
    private _pos = _tPos getPos [150 + random 200, random 360];
    _pos = [_pos] call VIC_fnc_findLandPosition;
    if (!(_pos isEqualTo [])) then {
        private _marker = "";
        if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
            _marker = createMarker [format ["mf_%1", diag_tickTime], _pos];
            _marker setMarkerShape "RECTANGLE";
            _marker setMarkerSize [_size/2,_size/2];
            _marker setMarkerColor "ColorYellow";
            _marker setMarkerText "APERS Field";
            _marker setMarkerAlpha 0.2;
        };
        STALKER_minefields pushBack [_pos,"APERS",_size,[],_marker];
    };
};

for "_i" from 1 to _iedCount do {
    if (_towns isEqualTo []) exitWith {};
    private _town = selectRandom _towns;
    private _tPos = locationPosition _town;
    private _pos = [_tPos, 200, 10] call VIC_fnc_findRoadPosition;
    if (isNil "_pos") then { continue; };
    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        _marker = createMarker [format ["ied_%1", diag_tickTime], _pos];
        _marker setMarkerShape "ICON";
        _marker setMarkerType "mil_triangle";
        _marker setMarkerColor "ColorRed";
        _marker setMarkerText "IED";
        _marker setMarkerAlpha 0.2;
    };
    STALKER_minefields pushBack [_pos,"IED",0,[],_marker];
};

if !(missionNamespace getVariable ["VIC_minefieldManagerRunning", false]) then {
    [] call VIC_fnc_startMinefieldManager;
};

