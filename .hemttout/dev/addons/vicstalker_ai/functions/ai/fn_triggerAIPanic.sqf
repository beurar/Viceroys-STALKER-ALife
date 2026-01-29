/*
    File: fn_triggerAIPanic.sqf
    Author: Viceroy's STALKER ALife
    Description:
        Sends nearby AI units into a panic state during emission buildup.
        Units will seek out a building within 300 meters and garrison it.

    Parameter(s):
        0: <ARRAY> (Optional) Array of AI units to affect. Defaults to all non-player units.
*/

params [ ["_units", allUnits select { alive _x && !isPlayer _x }] ];

// Only consider units with ranged weapons
_units = _units select {
    (primaryWeapon _x != "" || secondaryWeapon _x != "" || handgunWeapon _x != "")
};

if (isNil "STALKER_panicGroups") then { STALKER_panicGroups = []; };

[format ["fn_triggerAIPanic units: %1", count _units]] call VIC_fnc_debugLog;

// Exit if panic or AI behaviour tweaks are disabled
if !(missionNamespace getVariable ["VSA_AIPanicEnabled", true]) exitWith {};
if (["VSA_enableAIBehaviour", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};
if (["VSA_aiNightOnly", false] call VIC_fnc_getSetting && {dayTime > 5 && dayTime < 20}) exitWith {};

private _threshold = ["VSA_panicThreshold", 50] call VIC_fnc_getSetting;
private _groups = [];

{
    if (random 100 >= _threshold) then { continue }; 
    private _unit = _x;
    if (!alive _unit) then { continue }; 

    // Store current behaviour
    _unit setVariable ["vsa_savedBehaviour", behaviour _unit];
    _unit setVariable ["vsa_savedCombatMode", combatMode _unit];

    private _grp = group _unit;
    if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
        _grp setVariable ["lambs_danger_disablegroupAI", true];
        _unit setVariable ["lambs_danger_disableAI", true];
    };

    if (!(_grp in _groups)) then { _groups pushBack _grp; };
} forEach _units;

{
    private _grp = _x;
    private _leader = leader _grp;
    if (!alive _leader) then { continue };

    // Find the nearest building within 300m for the group to garrison
    private _searchRadius = 300;
    private _buildings = nearestObjects [_leader, ["House"], _searchRadius];
    // Filter out ruined or unfinished structures
    _buildings = _buildings select {
        private _type = toLower (typeOf _x);
        (_type find "ruin" == -1) &&
        (_type find "unfinished" == -1) &&
        (_type find "construction" == -1)
    };
    if (_buildings isEqualTo []) then { continue };
    private _building = _buildings select 0;

    private _pos = getPosATL _building;
    private _hasPlayers = (allPlayers select { _x distance _building < 15 }) isNotEqualTo [];

    if (_hasPlayers) then {
        if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
            [_grp, _pos, false] spawn lambs_wp_fnc_taskAssault;
        } else {
            [_grp, _pos] call BIS_fnc_taskPatrol;
        };
    } else {
        if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
            [_grp, _pos, 300, [], false, true, 0, false] call lambs_wp_fnc_taskGarrison;
        } else {
            [_grp, _pos] call BIS_fnc_taskDefend;
        };
    };

    {
        _x disableAI "AUTOCOMBAT";
        _x disableAI "TARGET";
        _x disableAI "AUTOTARGET";
        _x setBehaviour "COMBAT";
        _x setVariable ["vsa_panicGarrison", true];
    } forEach units _grp;

    STALKER_panicGroups pushBackUnique _grp;
} forEach _groups;

true
