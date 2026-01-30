/*
    Spawns clusters of chemical zone sites around a center position.
    Each cluster is anchored to the lowest point within a small grid
    so gas tends to form in valleys and depressions.

    Params:
        0: POSITION - search center
        1: NUMBER   - search radius
        2: NUMBER   - cluster count (optional)
        3: NUMBER   - duration in seconds (optional, -1 = default)
        4: NUMBER   - zones per cluster (optional, default 3)
*/
params ["_center","_radius", ["_count",-1], ["_duration",-1], ["_clusterSize",3]];

private _debug = ["VSA_debugMode", false] call VIC_fnc_getSetting;
if (_debug && {isServer}) then {
    if (isNil "STALKER_valleyBaseMarkers") then { STALKER_valleyBaseMarkers = [] };
    { if (_x != "") then { deleteMarker _x } } forEach STALKER_valleyBaseMarkers;
    STALKER_valleyBaseMarkers = [];
};

["spawnValleyChemicalZones"] call VIC_fnc_debugLog;

if (["VSA_enableChemicalZones", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["spawnValleyChemicalZones: disabled"] call VIC_fnc_debugLog;
};

if (isNil "STALKER_chemicalZones") then { STALKER_chemicalZones = []; };

if (isNil "STALKER_valleys") then {
    private _cached = ["STALKER_valleys"] call VIC_fnc_loadCache;
    if (!isNil {_cached}) then { STALKER_valleys = _cached; };
};

if (_count < 0) then { _count = ["VSA_chemicalZoneCount", 2] call VIC_fnc_getSetting; };
private _nightOnly  = ["VSA_chemicalNightOnly", false] call VIC_fnc_getSetting;
private _zoneRadius = ["VSA_chemicalZoneRadius", 50] call VIC_fnc_getSetting;

if (_nightOnly && {dayTime > 5 && dayTime < 20}) exitWith {
    ["spawnValleyChemicalZones: night only"] call VIC_fnc_debugLog;
};

private _centerPos = if (_center isEqualType objNull) then { getPos _center } else { _center };
private _availableValleys = [];
if (!isNil "STALKER_valleys") then {
    {
        private _near = false;
        {
            if (_centerPos distance2D _x <= _radius) exitWith { _near = true };
        } forEach _x;
        if (_near) then { _availableValleys pushBack _x };
    } forEach STALKER_valleys;
};
_availableValleys = [_availableValleys] call BIS_fnc_arrayShuffle;

for "_i" from 0 to (_count - 1) do {
    if (_i >= count _availableValleys) exitWith {};
    private _valley = _availableValleys select _i;
    private _pos = selectRandom _valley;
    if (_debug && {isServer}) then {
        private _name = format ["valleyAnchor_%1", diag_tickTime + random 1000];
        private _m = [_name, _pos, "ICON", "mil_warning", VIC_colorGasYellow] call VIC_fnc_createGlobalMarker;
        STALKER_valleyBaseMarkers pushBack _m;
    };
    for "_j" from 1 to _clusterSize do {
        private _offAng = random 360;
        private _offDist = random (_zoneRadius / 2);
        private _zonePos = [(_pos select 0) + _offDist * sin _offAng, (_pos select 1) + _offDist * cos _offAng, _pos select 2];
        _zonePos = [_zonePos] call VIC_fnc_findLandPosition;
        if !(isNil {_zonePos} || {_zonePos isEqualTo []}) then {
            [_zonePos, _zoneRadius, _duration] call VIC_fnc_spawnChemicalZone;
        };
    };
};

true
