/*
    Handles despawn and respawn of ambient herds based on player distance.
*/

["manageHerds"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_activeHerds") exitWith {};

{
    _x params ["_grp", "_type", "_pos"];
    private _near = [_pos, 1500] call VIC_fnc_hasPlayersNearby;
    if (_near) then {
        if (isNull _grp || { count units _grp == 0 }) then {
            private _size = ["VSA_ambientHerdSize", 4] call CBA_fnc_getSetting;
            private _new = createGroup civilian;
            for "_i" from 1 to _size do {
                private _u = _new createUnit ["C_ALF_Mutant", _pos, [], 0, "FORM"];
                _u disableAI "TARGET";
                _u disableAI "AUTOTARGET";
            };
            [_new, _pos] call BIS_fnc_taskPatrol;
            STALKER_activeHerds set [_forEachIndex, [_new, _type, _pos]];
        };
    } else {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            STALKER_activeHerds set [_forEachIndex, [grpNull, _type, _pos]];
        };
    };
} forEach STALKER_activeHerds;

