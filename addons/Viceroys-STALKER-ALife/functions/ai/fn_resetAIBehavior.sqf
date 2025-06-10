/*
    File: fn_resetAIBehavior.sqf
    Author: Viceroy's STALKER ALife
    Description:
        Restores AI behaviour after an emission has passed.

    Parameter(s):
        0: <ARRAY> (Optional) Array of AI units to restore. Defaults to all non-player units.
*/

params [ ["_units", allUnits select { alive _x && !isPlayer _x }] ];

[format ["fn_resetAIBehavior units: %1", count _units]] call VIC_fnc_debugLog;

// Exit if panic or AI behaviour tweaks are disabled
if !(missionNamespace getVariable ["VSA_AIPanicEnabled", true]) exitWith {};
if (["VSA_enableAIBehaviour", true] call CBA_fnc_getSetting isEqualTo false) exitWith {};
if (["VSA_aiNightOnly", false] call CBA_fnc_getSetting && {daytime > 5 && daytime < 20}) exitWith {};

{
    private _unit = _x;
    if (!alive _unit) then {
        continue;
    };

    // Restore saved behaviour and combat mode
    if (!isNil { _unit getVariable "vsa_savedBehaviour" }) then {
        _unit setBehaviour (_unit getVariable ["vsa_savedBehaviour", "AWARE"]);
        _unit setVariable ["vsa_savedBehaviour", nil];
    };

    if (!isNil { _unit getVariable "vsa_savedCombatMode" }) then {
        _unit setCombatMode (_unit getVariable ["vsa_savedCombatMode", "YELLOW"]);
        _unit setVariable ["vsa_savedCombatMode", nil];
    };

    _unit enableAI "AUTOCOMBAT";
    _unit enableAI "TARGET";
    _unit enableAI "AUTOTARGET";

} forEach _units;

true
