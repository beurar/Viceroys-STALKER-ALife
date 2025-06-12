/*
    Spawns a generic mutant nest with the given unit class.
    Params:
        0: POSITION - nest location
        1: STRING - unit class to spawn
*/
params ["_pos", "_class"];

["spawnMutantNest"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableMutants", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_mutantNests") then { STALKER_mutantNests = []; };

private _max = ["VSA_maxMutantNests", 3] call VIC_fnc_getSetting;
if ((count STALKER_mutantNests) >= _max) exitWith {};

private _nightOnly = ["VSA_nestsNightOnly", true] call VIC_fnc_getSetting;
if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

private _grp = createGroup east;
for "_i" from 1 to 3 do {
    private _u = _grp createUnit [_class, _pos, [], 0, "FORM"];
    [_u] call VIC_fnc_initMutantUnit;
};
private _nestObj = "Land_Campfire_F" createVehicle _pos;

STALKER_mutantNests pushBack [_nestObj, _grp, _pos, _class];

[_grp, _pos] call BIS_fnc_taskDefend;
