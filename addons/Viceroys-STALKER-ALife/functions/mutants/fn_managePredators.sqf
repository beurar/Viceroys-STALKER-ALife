/*
    Periodically spawns predator attacks on players and cleans up finished groups.
    STALKER_activePredators entries: [group, target, marker]
*/

["managePredators"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_activePredators") then { STALKER_activePredators = []; };

private _chance    = ["VSA_predatorAttackChance", 5] call VIC_fnc_getSetting;
private _nightOnly = ["VSA_predatorNightOnly", true] call VIC_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {
    // still cleanup existing predators
    {
        _x params ["_grp", "_target", "_marker"];
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
        };
        if (_marker != "") then { deleteMarker _marker }; 
    } forEach STALKER_activePredators;
    STALKER_activePredators = [];
};

if ((count allPlayers) > 0 && {random 100 < _chance}) then {
    private _player = selectRandom allPlayers;
    if (!isNull _player) then {
        [_player] call VIC_fnc_spawnPredatorAttack;
    };
};

private _range = ["VSA_predatorRange", 1500] call VIC_fnc_getSetting;

{ 
    _x params ["_grp", "_target", "_marker"];
    private _alive = if (isNull _grp) then {0} else { {alive _x} count units _grp };
    private _near = [_target, _range] call VIC_fnc_hasPlayersNearby;
    if (_alive == 0 || {!_near}) then {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
        };
        if (_marker != "") then { deleteMarker _marker };
        STALKER_activePredators set [_forEachIndex, objNull];
    };
} forEach STALKER_activePredators;
STALKER_activePredators = STALKER_activePredators - [objNull];
