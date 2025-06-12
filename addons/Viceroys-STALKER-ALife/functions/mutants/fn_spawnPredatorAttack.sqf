/*
    Spawns an aggressive mutant predator near the given player position and
    orders it to attack that player. Used by the ambient predator system and
    available through debug actions.

    Params:
        0: OBJECT - player to attack
*/
params ["_player"];

["spawnPredatorAttack"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableMutants", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_activePredators") then { STALKER_activePredators = []; };

private _range = ["VSA_predatorRange", 1500] call VIC_fnc_getSetting;
private _spawnPos = getPos _player getPos [_range, random 360];

private _chimeraClasses = ["armst_chimera"];
private _bloodsuckerClasses = ["armst_krovosos","armst_krovosos2"];

private _type = selectRandom ["chimera","bloodsucker"];
private _grp = createGroup east;

switch (_type) do {
    case "chimera": {
        private _u = _grp createUnit [selectRandom _chimeraClasses, _spawnPos, [], 0, "FORM"];
        [_u] call VIC_fnc_initMutantUnit;
    };
    case "bloodsucker": {
        for "_i" from 1 to 3 do {
            private _u = _grp createUnit [selectRandom _bloodsuckerClasses, _spawnPos, [], 0, "FORM"];
            [_u] call VIC_fnc_initMutantUnit;
        };
    };
};

[_grp, _player] call BIS_fnc_taskAttack;

private _markerName = format ["pred_%1", diag_tickTime];
private _marker = createMarker [_markerName, _spawnPos];
_marker setMarkerShape "ICON";
_marker setMarkerType "mil_warning";
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 1;

STALKER_activePredators pushBack [_grp, _player, _marker, true];
