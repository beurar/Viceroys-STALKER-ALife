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
    private _pos = [];
    private _road = objNull;

    for "_j" from 1 to 30 do {
        private _candidate = _center getPos [random _radius, random 360];
        _candidate = [_candidate] call VIC_fnc_findLandPosition;
        if (_candidate isEqualTo []) then { continue };

        if (!([_candidate] call VIC_fnc_isWaterPosition)) then {
            if ((nearestLocations [_candidate, ["NameVillage","NameCity","NameCityCapital","NameLocal"], _townDist]) isEqualTo []) then {
                _road = nearestRoad _candidate;
                if (!isNull _road) exitWith { _pos = getPos _road; };
            };
        };
    };

    if (_pos isEqualTo []) then { continue };

    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        _marker = createMarker [format ["amb_%1", diag_tickTime + _i], _pos];
        _marker setMarkerShape "ICON";
        _marker setMarkerType "mil_triangle";
        _marker setMarkerColor "ColorBlack";
        _marker setMarkerAlpha 0.2;
    };

    STALKER_ambushes pushBack [_pos, objNull, [], [], false, _marker];
};

true
