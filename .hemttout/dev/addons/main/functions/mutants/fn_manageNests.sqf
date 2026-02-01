/*
    Manages mutant nests, despawning or respawning the defenders based on player proximity.
*/

// ["manageNests"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_mutantNests") exitWith {};

{
    _x params ["_nest", "_grp", "_pos", "_class"];
    private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];
    private _near = [_pos, _dist] call VIC_fnc_hasPlayersNearby;
    if (_near) then {
        if (isNull _nest) then { _nest = "Land_Campfire_F" createVehicle _pos; };
        if (isNull _grp || { units _grp isEqualTo [] }) then {
            private _new = createGroup east;
            for "_i" from 1 to 3 do {
                private _u = _new createUnit [_class, _pos, [], 0, "FORM"];
                [_u] call VIC_fnc_initMutantUnit;
            };
            STALKER_mutantNests set [_forEachIndex, [_nest, _new, _pos, _class]];
        } else {
            STALKER_mutantNests set [_forEachIndex, [_nest, _grp, _pos, _class]];
        };
    } else {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
        };
        if (!isNull _nest) then { deleteVehicle _nest; };
        STALKER_mutantNests set [_forEachIndex, [objNull, grpNull, _pos, _class]];
    };
} forEach STALKER_mutantNests;
