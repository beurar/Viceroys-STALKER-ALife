/*
    File: fn_avoidAnomalyFields.sqf
    Author: Viceroy's STALKER ALife
    Description:
        Causes AI units to keep clear of anomaly field areas.
    Parameter(s): none
*/

["fn_avoidAnomalyFields"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (["VSA_enableAIBehaviour", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};
if !(missionNamespace getVariable ["VSA_fieldAvoidEnabled", true]) exitWith {};
if (["VSA_aiNightOnly", false] call VIC_fnc_getSetting && { daytime > 5 && daytime < 20 }) exitWith {};
if (isNil "STALKER_anomalyFields") exitWith {};

private _chance = ["VSA_aiAnomalyAvoidChance", 50] call VIC_fnc_getSetting;
private _buffer = ["VSA_aiAnomalyAvoidRange", 20] call VIC_fnc_getSetting;

private _fields = STALKER_anomalyFields apply { [ _x select 0, _x select 1 ] };
if (_fields isEqualTo []) exitWith {};

{
    if (random 100 >= _chance) then { continue; };
    private _unit = _x;
    if (!alive _unit || {isPlayer _unit}) then { continue; };

    private _field = [];
    {
        private _c = _x#0;
        private _r = _x#1;
        if (_unit distance _c < (_r + _buffer)) exitWith { _field = [_c, _r] };
    } forEach _fields;

    if !(_field isEqualTo []) then {
        private _center = _field#0;
        private _radius = _field#1;
        private _dir = _unit getDir _center;
        private _dest = [getPosATL _unit, (_radius + _buffer) * 1.2, _dir + 180] call BIS_fnc_relPos;
        _unit doMove _dest;
    };
} forEach allUnits;

true
