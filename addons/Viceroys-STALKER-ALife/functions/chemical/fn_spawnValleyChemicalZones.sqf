/*
    Spawns chemical zone sites around a center position.
    Each site is placed at the lowest point within a small grid
    to favour valleys and depressions.
    Params:
        0: POSITION - search center
        1: NUMBER   - search radius
        2: NUMBER   - zone count (optional)
        3: NUMBER   - duration in seconds (optional, -1 = default)
*/
params ["_center","_radius", ["_count",-1], ["_duration",-1]];

["spawnValleyChemicalZones"] call VIC_fnc_debugLog;

if (["VSA_enableChemicalZones", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_chemicalZones") then { STALKER_chemicalZones = []; };

if (_count < 0) then { _count = ["VSA_chemicalZoneCount", 2] call VIC_fnc_getSetting; };
private _nightOnly  = ["VSA_chemicalNightOnly", false] call VIC_fnc_getSetting;
private _zoneRadius = ["VSA_chemicalZoneRadius", 50] call VIC_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

for "_i" from 1 to _count do {
    private _base = _center getPos [random _radius, random 360];
    private _pos = [_base, 30, 10] call VIC_fnc_findValleyPosition;
    if (_pos isEqualTo []) then { continue };

    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        _marker = createMarker [format ["chem_%1", diag_tickTime + _i], ASLtoATL _pos];
        _marker setMarkerShape "ELLIPSE";
        _marker setMarkerSize [_zoneRadius,_zoneRadius];
        _marker setMarkerColor "ColorGreen";
        _marker setMarkerAlpha 0.2;
    };

    private _expires = if (_duration >= 0) then { diag_tickTime + _duration } else {-1};
    STALKER_chemicalZones pushBack [_pos,_zoneRadius,false,_marker,_expires];
};

true
