/*
    Periodically updates player proximity for mutant habitats and herds.
*/

// Mute debug log to reduce spam
// ["updateProximity"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

private _range = missionNamespace getVariable ["STALKER_activityRadius", 1500];

if (!isNil "STALKER_mutantHabitats") then {
    {
        _x params ["_area","_label","_grp","_pos","_anchor","_type","_max","_count","_near"];
        _near = [_anchor, _range] call VIC_fnc_hasPlayersNearby;
        STALKER_mutantHabitats set [_forEachIndex, [_area,_label,_grp,_pos,_anchor,_type,_max,_count,_near]];
    } forEach STALKER_mutantHabitats;
};

if (!isNil "STALKER_activeHerds") then {
    {
        _x params ["_leader","_grp","_max","_count","_near","_marker"];
        _near = [_leader, _range] call VIC_fnc_hasPlayersNearby;
        STALKER_activeHerds set [_forEachIndex, [_leader,_grp,_max,_count,_near,_marker]];
    } forEach STALKER_activeHerds;
};

true
