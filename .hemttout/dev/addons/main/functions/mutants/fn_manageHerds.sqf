/*
    Handles roaming mutant herds. The leader always remains in the world
    while the rest of the herd is only spawned when players are nearby.
    STALKER_activeHerds entries: [leader, group, max, count, near, marker]
*/

// ["manageHerds"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_activeHerds") exitWith {};
private _chance = ["VSA_mutantSpawnWeight",50] call VIC_fnc_getSetting;

{
    _x params ["_leader", "_grp", "_max", "_count", "_near", "_marker"];

    if (isNull _grp) then { _grp = createGroup civilian; };

    if (isNull _leader || {!alive _leader}) then {
        private _pos = if (!isNull _leader) then { getPos _leader } else { [random worldSize, random worldSize, 0] };
        _pos = [_pos] call VIC_fnc_findLandPosition;
        if (isNil {_pos} || {_pos isEqualTo []}) then { continue };
        if ({ alive _x } count units _grp > 0) then {
            _leader = selectRandom (units _grp);
        } else {
            _leader = _grp createUnit ["C_ALF_Mutant", _pos, [], 0, "FORM"];
            [_leader] call VIC_fnc_initMutantUnit;
            _leader disableAI "TARGET";
            _leader disableAI "AUTOTARGET";
            _leader setVariable ["VSA_herdIndex", _forEachIndex];
            _leader addEventHandler ["Killed", { [_this#0] call VIC_fnc_onMutantKilled }];
            [_grp, _pos] call BIS_fnc_taskPatrol;
            if (_count < 1) then { _count = 1; };
        };
    };

    private _pos = getPos _leader;
    if (_marker != "") then { _marker setMarkerPos _pos; };

    if (_near) then {
        private _alive = { alive _x } count units _grp;
        if (_alive < _count) then {
            for "_i" from (_alive + 1) to _count do {
                private _u = _grp createUnit ["C_ALF_Mutant", _pos, [], 0, "FORM"];
                [_u] call VIC_fnc_initMutantUnit;
                _u disableAI "TARGET";
                _u disableAI "AUTOTARGET";
                _u setVariable ["VSA_herdIndex", _forEachIndex];
                _u addEventHandler ["Killed", { [_this#0] call VIC_fnc_onMutantKilled }];
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

    if (_marker != "") then {
        _marker setMarkerAlpha ([0.2, 1] select _near);
    };

    STALKER_activeHerds set [_forEachIndex, [_leader, _grp, _max, _count, _near, _marker]];
} forEach STALKER_activeHerds;

