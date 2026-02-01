/*
    Periodically spawns predator attacks on players and cleans up finished groups.
    STALKER_activePredators entries: [group, target, marker, near]
*/

// ["managePredators"] call VIC_fnc_debugLog;

if (!isServer) exitWith {
    // ["managePredators exit: not server"] call VIC_fnc_debugLog;
};
if (isNil "STALKER_activePredators") then { STALKER_activePredators = []; };

private _chance = ["VSA_predatorAttackChance", 5] call VIC_fnc_getSetting;

if (allPlayers isNotEqualTo [] && {random 100 < _chance}) then {
    private _player = selectRandom allPlayers;
    if (!isNull _player) then {
        [_player] call VIC_fnc_spawnPredatorAttack;
    };
};

private _range = ["VSA_predatorRange", 1500] call VIC_fnc_getSetting;
{
    _x params ["_grp", "_target", "_marker", "_near"];
    private _alive = if (isNull _grp) then {0} else { {alive _x} count units _grp };
    _near = [_target, _range] call VIC_fnc_hasPlayersNearby;
    if (_alive == 0 || {!_near}) then {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            _grp = grpNull;
        };
    };
    if (_marker != "") then {
        [_marker, [0.2, 1] select (_alive > 0 && _near)] remoteExec ["setMarkerAlpha", 0];
    };
    STALKER_activePredators set [_forEachIndex, [_grp, _target, _marker, _near]];
} forEach STALKER_activePredators;

// ["managePredators completed"] call VIC_fnc_debugLog;
