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

if (!isServer) exitWith {};

if (["VSA_enableMutants", true] call CBA_fnc_getSetting isEqualTo false) exitWith {};

private _groupCount = ["VSA_mutantGroupCountHostile", 1] call CBA_fnc_getSetting;
private _threat     = ["VSA_mutantThreat", 3] call CBA_fnc_getSetting;
private _nightOnly  = ["VSA_mutantNightOnlyHostile", false] call CBA_fnc_getSetting;
private _spawnWeight = ["VSA_mutantSpawnWeight", 50] call CBA_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

for "_i" from 1 to _groupCount do {
    if (random 100 >= _spawnWeight) then { continue }; 
    private _spawnPos = _centerPos getPos [100 + random 100, random 360];
    private _grp = createGroup east;
    for "_j" from 1 to _threat do {
        _grp createUnit ["O_ALF_Mutant", _spawnPos, [], 0, "FORM"];
    };
    [_grp, _spawnPos] call BIS_fnc_taskPatrol;
};

