/*
    Handles roaming mutant herds. The leader always remains in the world
    while the rest of the herd is only spawned when players are nearby.
    STALKER_activeHerds entries: [leader, group, max, count]
*/

["manageHerds"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_activeHerds") exitWith {};
private _chance = ["VSA_mutantSpawnWeight",50] call VIC_fnc_getSetting;

{
    _x params ["_leader", "_grp", "_max", "_count"];

    if (isNull _grp) then { _grp = createGroup civilian; };

    if (isNull _leader || {!alive _leader}) then {
        private _pos = if (!isNull _leader) then { getPos _leader } else { [random worldSize, random worldSize, 0] };
        if ({ alive _x } count units _grp > 0) then {
            _leader = selectRandom (units _grp);
        } else {
            _leader = _grp createUnit ["C_ALF_Mutant", _pos, [], 0, "FORM"];
            _leader disableAI "TARGET";
            _leader disableAI "AUTOTARGET";
            [_grp, _pos] call BIS_fnc_taskPatrol;
            if (_count < 1) then { _count = 1; };
        };
    };

    private _pos = getPos _leader;
    private _dist = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;
    private _near = [_pos, _dist] call VIC_fnc_hasPlayersNearby;

    if (_near) then {
        private _alive = { alive _x } count units _grp;
        if (_alive < _count) then {
            for "_i" from (_alive + 1) to _count do {
                private _u = _grp createUnit ["C_ALF_Mutant", _pos, [], 0, "FORM"];
                _u disableAI "TARGET";
                _u disableAI "AUTOTARGET";
            };
            [_grp, _pos] call BIS_fnc_taskPatrol;
        };
        _count = { alive _x } count units _grp;
    } else {
        {
            if (_x != _leader) then { deleteVehicle _x }; 
        } forEach units _grp;

        if (_count < _max && { random 100 < _chance }) then {
            _count = _count + 1;
            if (_count > _max) then { _count = _max; };
        };
    };

    STALKER_activeHerds set [_forEachIndex, [_leader, _grp, _max, _count]];
} forEach STALKER_activeHerds;

