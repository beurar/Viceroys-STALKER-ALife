/*
    Spawns multiple radiation zones around a position using CBA settings.
    Params:
        0: POSITION - center of the area
        1: NUMBER   - search radius
        2: NUMBER   - number of zones to spawn (optional)
        3: NUMBER   - zone duration in seconds (optional, -1 = until cleaned)
*/
params ["_center","_radius", ["_count", -1], ["_duration", -1]];

["spawnRandomRadiationZones"] call VIC_fnc_debugLog;

if (["VSA_enableRadiation", true] call CBA_fnc_getSetting isEqualTo false) exitWith {};

if (_count < 0) then {
    _count = ["VSA_radiationZoneCount", 2] call CBA_fnc_getSetting;
};
private _weight = ["VSA_radiationSpawnWeight", 50] call CBA_fnc_getSetting;
private _nightOnly = ["VSA_radiationNightOnly", false] call CBA_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

for "_i" from 1 to _count do {
    if (random 100 >= _weight) then { continue };
    private _pos = _center getPos [random _radius, random 360];
    [_pos, 50, _duration] call VIC_fnc_spawnRadiationZone;
};

