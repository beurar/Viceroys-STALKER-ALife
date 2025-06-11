/*
    Spawns a bloodsucker nest at the given position and records it for ALife management.
    Params:
        0: POSITION - location of the nest
*/
params ["_pos"];

["spawnBloodsuckerNest"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableMutants", true] call CBA_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_mutantNests") then { STALKER_mutantNests = []; };

private _max = ["VSA_maxMutantNests", 3] call CBA_fnc_getSetting;
if ((count STALKER_mutantNests) >= _max) exitWith {};

private _nightOnly = ["VSA_nestsNightOnly", true] call CBA_fnc_getSetting;
if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

private _grp = createGroup east;
for "_i" from 1 to 3 do {
    _grp createUnit ["O_ALF_Bloodsucker", _pos, [], 0, "FORM"];
};
private _nestObj = "Land_Campfire_F" createVehicle _pos;

STALKER_mutantNests pushBack [_nestObj, _grp, _pos];

[_grp, _pos] call BIS_fnc_taskDefend;

