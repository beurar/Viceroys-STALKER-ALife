/*
    Handles despawn and respawn of hostile mutant groups.
*/

["manageHostiles"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_activeHostiles") exitWith {};

private _size = ["VSA_mutantThreat", 3] call VIC_fnc_getSetting;

{
    _x params ["_grp", "_type", "_pos"];
    private _near = [_pos, 1500] call VIC_fnc_hasPlayersNearby;
    if (_near) then {
        if (isNull _grp || { count units _grp == 0 }) then {
            private _new = createGroup east;
            for "_i" from 1 to _size do { _new createUnit ["O_ALF_Mutant", _pos, [], 0, "FORM"]; };
            [_new, _pos] call BIS_fnc_taskPatrol;
            STALKER_activeHostiles set [_forEachIndex, [_new, _type, _pos]];
        };
    } else {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            STALKER_activeHostiles set [_forEachIndex, [grpNull, _type, _pos]];
        };
    };
} forEach STALKER_activeHostiles;

