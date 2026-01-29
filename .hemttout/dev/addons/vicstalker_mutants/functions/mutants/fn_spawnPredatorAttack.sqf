/*
    Spawns an aggressive mutant predator near the given player position and
    orders it to attack that player. Used by the ambient predator system and
    available through debug actions.

    Params:
        0: OBJECT - player to attack
*/
params ["_player"];

["spawnPredatorAttack"] call VIC_fnc_debugLog;

if (!isServer) exitWith {
    ["spawnPredatorAttack exit: not server"] call VIC_fnc_debugLog;
};

if (["VSA_enableMutants", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["spawnPredatorAttack exit: mutants disabled"] call VIC_fnc_debugLog;
};

if (isNil "STALKER_activePredators") then { STALKER_activePredators = []; };

private _range = ["VSA_predatorRange", 1500] call VIC_fnc_getSetting;
private _spawnPos = _player getPos [_range, random 360];
_spawnPos = [_spawnPos] call VIC_fnc_findLandPosition;
if (isNil {_spawnPos} || {_spawnPos isEqualTo []}) exitWith {
    ["spawnPredatorAttack exit: invalid position"] call VIC_fnc_debugLog;
};

if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
    private _spawnMarker = format ["pred_%1", diag_tickTime];
    [_spawnMarker, _spawnPos, "ICON", "mil_dot", VIC_colorMutant, 1, "Predator Spawn"] call VIC_fnc_createGlobalMarker;
};

private _dogClasses       = ["armst_blinddog1","armst_blinddog2","armst_blinddog3"];
private _boarClasses      = ["armst_boar","armst_boar2"];
private _snorkClasses     = ["armst_snork"];
private _pseudodogClasses = ["armst_pseudodog","armst_pseudodog2"];
private _catClasses       = ["armst_cat"];
private _chimeraClasses   = ["armst_chimera"];
private _bloodsuckerClasses = ["armst_krovosos","armst_krovosos2"];
private _goliathClasses   = ["WBK_Goliaph_3"];
private _crusherClasses   = ["WBK_SpecialZombie_Smasher_3"];

private _isNight = !(dayTime > 5 && dayTime < 20);

private _dayTypes   = ["dog","boar","snork"];
private _nightTypes = ["chimera","bloodsucker","cat","pseudodog"];
private _rareTypes  = ["goliath","crusher"];

private _type = if (random 100 < 3) then { selectRandom _rareTypes } else {
    if (_isNight) then { selectRandom _nightTypes } else { selectRandom _dayTypes }
};

private _mapType = switch (_type) do {
    case "dog": {"Blind Dog"};
    case "boar": {"Boar"};
    case "snork": {"Snork"};
    case "pseudodog": {"Pseudodog"};
    case "cat": {"Cat"};
    case "chimera": {"Chimera"};
    case "bloodsucker": {"Bloodsucker"};
    case "goliath": {"Behemoth"};
    case "crusher": {"Smasher"};
    default {""};
};
if (_mapType != "" && { !( [_mapType] call VIC_fnc_isMutantEnabled ) }) exitWith {
    [format ["spawnPredatorAttack exit: %1 disabled", _mapType]] call VIC_fnc_debugLog;
};
private _grp = createGroup east;

switch (_type) do {
    case "dog": {
        for "_i" from 1 to 4 do {
            private _u = _grp createUnit [selectRandom _dogClasses, _spawnPos, [], 0, "FORM"];
            [_u] call VIC_fnc_initMutantUnit;
        };
    };
    case "boar": {
        for "_i" from 1 to 3 do {
            private _u = _grp createUnit [selectRandom _boarClasses, _spawnPos, [], 0, "FORM"];
            [_u] call VIC_fnc_initMutantUnit;
        };
    };
    case "snork": {
        for "_i" from 1 to 3 do {
            private _u = _grp createUnit [selectRandom _snorkClasses, _spawnPos, [], 0, "FORM"];
            [_u] call VIC_fnc_initMutantUnit;
        };
    };
    case "pseudodog": {
        for "_i" from 1 to 3 do {
            private _u = _grp createUnit [selectRandom _pseudodogClasses, _spawnPos, [], 0, "FORM"];
            [_u] call VIC_fnc_initMutantUnit;
        };
    };
    case "cat": {
        for "_i" from 1 to 2 do {
            private _u = _grp createUnit [selectRandom _catClasses, _spawnPos, [], 0, "FORM"];
            [_u] call VIC_fnc_initMutantUnit;
        };
    };
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
    case "goliath": {
        private _u = _grp createUnit [selectRandom _goliathClasses, _spawnPos, [], 0, "FORM"];
        [_u] call VIC_fnc_initMutantUnit;
    };
    case "crusher": {
        private _u = _grp createUnit [selectRandom _crusherClasses, _spawnPos, [], 0, "FORM"];
        [_u] call VIC_fnc_initMutantUnit;
    };
};

[_grp, _player] call BIS_fnc_taskAttack;

private _markerName = format ["pred_%1", diag_tickTime];
private _marker = _markerName;
[_marker, _spawnPos, "ICON", "mil_warning", VIC_colorMutant, 1] call VIC_fnc_createGlobalMarker;

STALKER_activePredators pushBack [_grp, _player, _marker, true];

["spawnPredatorAttack completed"] call VIC_fnc_debugLog;
