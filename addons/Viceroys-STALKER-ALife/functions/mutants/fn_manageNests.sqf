/*
    Manages bloodsucker nests, despawning or respawning the defenders.
*/

["manageNests"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_mutantNests") exitWith {};

{
    _x params ["_nest", "_grp", "_pos"];
    private _near = [_pos, 1500] call VIC_fnc_hasPlayersNearby;
    if (_near) then {
        if (isNull _nest) then { _nest = "Land_Campfire_F" createVehicle _pos; };
        if (isNull _grp || { count units _grp == 0 }) then {
            private _new = createGroup east;
            for "_i" from 1 to 3 do { _new createUnit ["O_ALF_Bloodsucker", _pos, [], 0, "FORM"]; };
            STALKER_mutantNests set [_forEachIndex, [_nest, _new, _pos]];
        } else {
            STALKER_mutantNests set [_forEachIndex, [_nest, _grp, _pos]];
        };
    } else {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
        };
        if (!isNull _nest) then { deleteVehicle _nest; };
        STALKER_mutantNests set [_forEachIndex, [objNull, grpNull, _pos]];
    };
} forEach STALKER_mutantNests;

