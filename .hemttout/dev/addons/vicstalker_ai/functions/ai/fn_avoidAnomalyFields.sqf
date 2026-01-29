/*
    File: fn_avoidAnomalyFields.sqf
    Author: Viceroy's STALKER ALife
    Description:
        Causes AI units to keep clear of anomaly field areas.
    Parameter(s): none
*/


["fn_avoidAnomalyFields"] call VIC_fnc_debugLog;

if (!isServer) exitWith {
    ["fn_avoidAnomalyFields exit: not server"] call VIC_fnc_debugLog;
};
if (["VSA_enableAIBehaviour", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["fn_avoidAnomalyFields exit: behaviour disabled"] call VIC_fnc_debugLog;
};
if !(missionNamespace getVariable ["VSA_fieldAvoidEnabled", true]) exitWith {
    ["fn_avoidAnomalyFields exit: disabled"] call VIC_fnc_debugLog;
};
if (["VSA_aiNightOnly", false] call VIC_fnc_getSetting && { dayTime > 5 && dayTime < 20 }) exitWith {
    ["fn_avoidAnomalyFields exit: day time"] call VIC_fnc_debugLog;
};
if (isNil "STALKER_anomalyFields") exitWith {
    ["fn_avoidAnomalyFields exit: no fields"] call VIC_fnc_debugLog;
};

private _chance = ["VSA_aiAnomalyAvoidChance", 50] call VIC_fnc_getSetting;
private _buffer = ["VSA_aiAnomalyAvoidRange", 20] call VIC_fnc_getSetting;

private _fields = STALKER_anomalyFields apply { [ _x select 0, _x select 2 ] };
if (_fields isEqualTo []) exitWith {
    ["fn_avoidAnomalyFields exit: no valid fields"] call VIC_fnc_debugLog;
};

{
    if (random 100 >= _chance) then { continue; };
    private _unit = _x;
    if (!alive _unit || {isPlayer _unit}) then { continue; };

    private _field = [];
    {
        _x params ["_c","_r"];
        if (_unit distance _c < (_r + _buffer)) exitWith { _field = [_c, _r] };
    } forEach _fields;

    if (_field isNotEqualTo []) then {
        _field params ["_center","_radius"];
        private _dir = _unit getDir _center;
        private _dest = [getPosATL _unit, (_radius + _buffer) * 1.2, _dir + 180] call BIS_fnc_relPos;
        _unit doMove _dest;
    };
} forEach allUnits;

["fn_avoidAnomalyFields completed"] call VIC_fnc_debugLog;

true
