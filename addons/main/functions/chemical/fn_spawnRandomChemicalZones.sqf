/*
    Spawns multiple chemical gas zones around a position using CBA settings.
    Params:
        0: POSITION - center of the area
        1: NUMBER   - search radius
        2: NUMBER   - number of zones to spawn (optional)
        3: NUMBER   - zone duration in seconds (optional, -1 = default)
*/
params ["_center","_radius", ["_count", -1], ["_duration", -1]];

["spawnRandomChemicalZones"] call VIC_fnc_debugLog;

if (["VSA_enableChemicalZones", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["spawnRandomChemicalZones: disabled"] call VIC_fnc_debugLog;
};

if (_count < 0) then {
    _count = ["VSA_chemicalZoneCount", 2] call VIC_fnc_getSetting;
};
private _weight = ["VSA_chemicalSpawnWeight", 50] call VIC_fnc_getSetting;
private _nightOnly = ["VSA_chemicalNightOnly", false] call VIC_fnc_getSetting;
private _zoneRadius = ["VSA_chemicalZoneRadius", 50] call VIC_fnc_getSetting;

if (_nightOnly && {dayTime > 5 && dayTime < 20}) exitWith {
    ["spawnRandomChemicalZones: night only"] call VIC_fnc_debugLog;
};

for "_i" from 1 to _count do {
    if (random 100 >= _weight) then { continue };
    private _centerPos = if (_center isEqualType objNull) then { getPos _center } else { _center };
    private _ang = random 360;
    private _dist = random _radius;
    private _base = [(_centerPos select 0) + _dist * sin _ang, (_centerPos select 1) + _dist * cos _ang, _centerPos select 2];
    private _pos = [_base] call VIC_fnc_findLandPosition;
    if !(isNil {_pos} || {_pos isEqualTo []}) then {
        [_pos, _zoneRadius, _duration] call VIC_fnc_spawnChemicalZone;
    };
};

