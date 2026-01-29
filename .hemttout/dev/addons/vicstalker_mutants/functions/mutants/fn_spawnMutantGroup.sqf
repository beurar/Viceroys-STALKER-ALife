/*
    Spawns hostile mutant groups after an emission.
    Settings are retrieved via CBA:
      - VSA_mutantGroupCountHostile: how many groups to spawn (default 1)
      - VSA_mutantThreat:            how many units per group (default 3)
      - VSA_mutantNightOnlyHostile:  only spawn at night if true (default false)
      - VSA_mutantSpawnWeight:       chance per group to actually spawn
      - VSA_enableMutants:           master toggle for mutant systems

    _centerPos - position around which groups will appear
*/
params ["_centerPos"];

["spawnMutantGroup"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableMutants", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_activeHostiles") then { STALKER_activeHostiles = []; };

private _groupCount = ["VSA_mutantGroupCountHostile", 1] call VIC_fnc_getSetting;
private _threat     = ["VSA_mutantThreat", 3] call VIC_fnc_getSetting;
private _nightOnly  = ["VSA_mutantNightOnlyHostile", false] call VIC_fnc_getSetting;
private _spawnWeight = ["VSA_mutantSpawnWeight", 50] call VIC_fnc_getSetting;

if (_nightOnly && {dayTime > 5 && dayTime < 20}) exitWith {};

private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];
if (!([_centerPos, _dist] call VIC_fnc_hasPlayersNearby)) exitWith {};

for "_i" from 1 to _groupCount do {
    if (random 100 >= _spawnWeight) then { continue }; 
    private _spawnPos = _centerPos getPos [100 + random 100, random 360];
    _spawnPos = [_spawnPos] call VIC_fnc_findLandPosition;
    if (isNil {_spawnPos} || {_spawnPos isEqualTo []}) then { continue };
    private _grp = createGroup east;
    for "_j" from 1 to _threat do {
        private _u = _grp createUnit ["O_ALF_Mutant", _spawnPos, [], 0, "FORM"];
        [_u] call VIC_fnc_initMutantUnit;
    };
    [_grp, _spawnPos] call BIS_fnc_taskPatrol;
    private _markerName = format ["hostile_%1_%2", _i, diag_tickTime];
    private _marker = _markerName;
    [_marker, _spawnPos, "ICON", "mil_dot", VIC_colorMutant, 1] call VIC_fnc_createGlobalMarker;
    STALKER_activeHostiles pushBack [_grp, "hostile", _spawnPos, _marker, true];
}; 

