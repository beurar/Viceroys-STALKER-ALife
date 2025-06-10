/*
    Spawns hostile mutant groups after an emission.
    Settings are retrieved via CBA:
      - ALF_mutantGroupCount: how many groups to spawn (default 1)
      - ALF_mutantThreat:    how many units per group (default 3)
      - ALF_mutantNightOnly: only spawn at night if true (default false)

    _centerPos - position around which groups will appear
*/
params ["_centerPos"];

if (!isServer) exitWith {};

private _groupCount = ["ALF_mutantGroupCount", 1] call CBA_fnc_getSetting;
private _threat     = ["ALF_mutantThreat", 3]     call CBA_fnc_getSetting;
private _nightOnly  = ["ALF_mutantNightOnly", false] call CBA_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

for "_i" from 1 to _groupCount do {
    private _spawnPos = _centerPos getPos [100 + random 100, random 360];
    private _grp = createGroup east;
    for "_j" from 1 to _threat do {
        _grp createUnit ["O_ALF_Mutant", _spawnPos, [], 0, "FORM"];
    };
    [_grp, _spawnPos] call BIS_fnc_taskPatrol;
};
