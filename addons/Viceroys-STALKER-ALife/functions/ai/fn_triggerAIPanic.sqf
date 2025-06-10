/*
    File: fn_triggerAIPanic.sqf
    Author: Viceroy's STALKER ALife
    Description:
        Sends nearby AI units into a panic state during emission buildup.
        Units will try to move inside the nearest building or trench.

    Parameter(s):
        0: <ARRAY> (Optional) Array of AI units to affect. Defaults to all non-player units.
*/

params [ ["_units", allUnits select { alive _x && !isPlayer _x }] ];

[format ["fn_triggerAIPanic units: %1", count _units]] call VIC_fnc_debugLog;

// Exit if panic or AI behaviour tweaks are disabled
if !(missionNamespace getVariable ["VSA_AIPanicEnabled", true]) exitWith {};
if (["VSA_enableAIBehaviour", true] call CBA_fnc_getSetting isEqualTo false) exitWith {};
if (["VSA_aiNightOnly", false] call CBA_fnc_getSetting && {daytime > 5 && daytime < 20}) exitWith {};
private _threshold = ["VSA_panicThreshold", 50] call CBA_fnc_getSetting;

{
    if (random 100 >= _threshold) exitWith {};
    private _unit = _x;
    if (!alive _unit) exitWith {};

    // Remember original behaviour so it can be restored later
    _unit setVariable ["vsa_savedBehaviour", behaviour _unit];
    _unit setVariable ["vsa_savedCombatMode", combatMode _unit];

    // Determine a safe position - preference is a trench, otherwise a building
    private _safePos = [];

    private _trenches = nearestObjects [_unit, ["Land_Trench_01_F"], 50];
    if (count _trenches > 0) then {
        _safePos = getPosATL (_trenches select 0);
    } else {
        private _building = nearestBuilding _unit;
        if (!isNull _building) then {
            _safePos = _building buildingPos 0;
            if (_safePos isEqualTo [0,0,0]) then {
                _safePos = getPosATL _building;
            };
        };
    };

    if (!(_safePos isEqualTo [])) then {
        _unit doMove _safePos;
    };

    // Disable automatic behaviour changes during panic
    _unit disableAI "AUTOCOMBAT";
    _unit disableAI "TARGET";
    _unit disableAI "AUTOTARGET";
    _unit setBehaviour "COMBAT";

} forEach _units;

true
