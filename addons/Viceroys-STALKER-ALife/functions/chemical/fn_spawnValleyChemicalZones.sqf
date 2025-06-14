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

["spawnValleyChemicalZones"] call VIC_fnc_debugLog;

if (["VSA_enableChemicalZones", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_chemicalZones") then { STALKER_chemicalZones = []; };

if (_count < 0) then { _count = ["VSA_chemicalZoneCount", 2] call VIC_fnc_getSetting; };
private _nightOnly  = ["VSA_chemicalNightOnly", false] call VIC_fnc_getSetting;
private _zoneRadius = ["VSA_chemicalZoneRadius", 50] call VIC_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

for "_i" from 1 to _count do {
    private _centerPos = if (_center isEqualType objNull) then { getPos _center } else { _center };
    private _ang = random 360;
    private _dist = random _radius;
    private _base = [(_centerPos select 0) + _dist * sin _ang, (_centerPos select 1) + _dist * cos _ang, _centerPos select 2];
    private _pos = [_base, 30, 10] call VIC_fnc_findValleyPosition;
    if (_pos isEqualTo []) then { continue };

    for "_j" from 1 to _clusterSize do {
        private _offAng = random 360;
        private _offDist = random (_zoneRadius / 2);
        private _zonePos = [(_pos select 0) + _offDist * sin _offAng, (_pos select 1) + _offDist * cos _offAng, _pos select 2];
        [_zonePos, _zoneRadius, _duration] call VIC_fnc_spawnChemicalZone;
    };
};

true
