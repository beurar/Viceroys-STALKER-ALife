/*
    Handles despawn and respawn of hostile mutant groups.
*/

// ["manageHostiles"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_activeHostiles") exitWith {};

private _size = ["VSA_mutantThreat", 3] call VIC_fnc_getSetting;

{
    _x params ["_grp", "_type", "_pos", "_marker", "_near"];
    private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];
    _near = [_pos, _dist] call VIC_fnc_hasPlayersNearby;
    if (_near) then {
        if (isNull _grp || { units _grp isEqualTo [] }) then {
            private _new = createGroup east;
            for "_i" from 1 to _size do {
                private _u = _new createUnit ["O_ALF_Mutant", _pos, [], 0, "FORM"];
                [_u] call VIC_fnc_initMutantUnit;
            };
            [_new, _pos] call BIS_fnc_taskPatrol;
            _grp = _new;
        };
    } else {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            _grp = grpNull;
        };
    };
    if (_marker != "") then { _marker setMarkerAlpha ([0.2, 1] select _near); };
    STALKER_activeHostiles set [_forEachIndex, [_grp, _type, _pos, _marker, _near]];
} forEach STALKER_activeHostiles;

