/*
    File: fn_toggleFieldAvoid.sqf
    Author: Viceroy's STALKER ALife
    Description:
        Toggles AI avoidance of anomaly fields for testing.
*/


["fn_toggleFieldAvoid"] call VIC_fnc_debugLog;

if (!isServer) exitWith {
    ["fn_toggleFieldAvoid exit: not server"] call VIC_fnc_debugLog;
};

missionNamespace setVariable ["VSA_fieldAvoidEnabled", !(missionNamespace getVariable ["VSA_fieldAvoidEnabled", true]), true];
private _state = missionNamespace getVariable ["VSA_fieldAvoidEnabled", true];
[format ["Field avoidance %1", ["disabled","enabled"] select _state]] call VIC_fnc_debugLog;

["fn_toggleFieldAvoid completed"] call VIC_fnc_debugLog;

true
