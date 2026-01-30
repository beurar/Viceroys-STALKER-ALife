/*
    File: fn_avoidAnomalies.sqf
    Author: Viceroy's STALKER ALife
    Description:
        Causes nearby AI to move away from active anomalies based on a chance.
    Parameter(s): none
*/

["fn_avoidAnomalies"] call VIC_fnc_debugLog;

if (!isServer) exitWith {
    ["fn_avoidAnomalies exit: not server"] call VIC_fnc_debugLog;
};
if (["VSA_enableAIBehaviour", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["fn_avoidAnomalies exit: behaviour disabled"] call VIC_fnc_debugLog;
};
if (["VSA_aiNightOnly", false] call VIC_fnc_getSetting && { dayTime > 5 && dayTime < 20 }) exitWith {
    ["fn_avoidAnomalies exit: day time"] call VIC_fnc_debugLog;
};
if (isNil "STALKER_anomalyFields") exitWith {
    ["fn_avoidAnomalies exit: no fields"] call VIC_fnc_debugLog;
};

private _chance = ["VSA_aiAnomalyAvoidChance", 50] call VIC_fnc_getSetting;
private _range  = ["VSA_aiAnomalyAvoidRange", 20] call VIC_fnc_getSetting;

private _anoms = [];
{
    private _objs = _x select 5;
    _anoms append _objs;
} forEach STALKER_anomalyFields;
if (_anoms isEqualTo []) exitWith {};

{
    if (random 100 >= _chance) then { continue; };
    private _unit = _x;
    if (!alive _unit || {isPlayer _unit}) then { continue; };

    private _near = objNull;
    {
        if (_unit distance _x < _range) exitWith { _near = _x; };
    } forEach _anoms;

    if (!isNull _near) then {
        private _dir = _unit getDir _near;
        private _dest = [getPosATL _unit, _range * 2, _dir + 180] call BIS_fnc_relPos;
        _unit doMove _dest;
    };
} forEach allUnits;

["fn_avoidAnomalies completed"] call VIC_fnc_debugLog;

true
