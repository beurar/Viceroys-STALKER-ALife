/*
    Periodically updates player proximity for mutant habitats and herds.
*/
["updateProximity"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

private _range = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;

if (!isNil "STALKER_mutantHabitats") then {
    {
        _x params ["_area","_label","_grp","_pos","_type","_max","_count","_near"];
        _near = [_pos,_range] call VIC_fnc_hasPlayersNearby;
        STALKER_mutantHabitats set [_forEachIndex, [_area,_label,_grp,_pos,_type,_max,_count,_near]];
    } forEach STALKER_mutantHabitats;
};

if (!isNil "STALKER_activeHerds") then {
    {
        _x params ["_leader","_grp","_max","_count","_near"];
        _near = [getPos _leader,_range] call VIC_fnc_hasPlayersNearby;
        STALKER_activeHerds set [_forEachIndex, [_leader,_grp,_max,_count,_near]];
    } forEach STALKER_activeHerds;
};

true
