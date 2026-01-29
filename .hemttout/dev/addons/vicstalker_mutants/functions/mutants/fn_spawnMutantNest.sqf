/*
    Spawns a generic mutant nest with the given unit class.
    Params:
        0: POSITION - nest location
        1: STRING - unit class to spawn
*/
params ["_pos", "_class"];
["spawnMutantNest"] call VIC_fnc_debugLog;

_pos = [_pos] call VIC_fnc_findLandPosition;
if (isNil {_pos} || {_pos isEqualTo []}) exitWith {
    ["spawnMutantNest exit: invalid position"] call VIC_fnc_debugLog;
};

if (!isServer) exitWith {
    ["spawnMutantNest exit: not server"] call VIC_fnc_debugLog;
};

if (["VSA_enableMutants", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["spawnMutantNest exit: mutants disabled"] call VIC_fnc_debugLog;
};

if (isNil "STALKER_mutantNests") then { STALKER_mutantNests = []; };

private _max = ["VSA_maxMutantNests", 3] call VIC_fnc_getSetting;
if ((count STALKER_mutantNests) >= _max) exitWith {
    ["spawnMutantNest exit: max nests"] call VIC_fnc_debugLog;
};

private _nightOnly = ["VSA_nestsNightOnly", true] call VIC_fnc_getSetting;
if (_nightOnly && {dayTime > 5 && dayTime < 20}) exitWith {
    ["spawnMutantNest exit: day time"] call VIC_fnc_debugLog;
};

private _grp = createGroup east;
for "_i" from 1 to 3 do {
    private _u = _grp createUnit [_class, _pos, [], 0, "FORM"];
    [_u] call VIC_fnc_initMutantUnit;
};
private _nestObj = "Land_Campfire_F" createVehicle _pos;

[_pos] call VIC_fnc_createProximityAnchor;

STALKER_mutantNests pushBack [_nestObj, _grp, _pos, _class];

[_grp, _pos] call BIS_fnc_taskDefend;

["spawnMutantNest completed"] call VIC_fnc_debugLog;
