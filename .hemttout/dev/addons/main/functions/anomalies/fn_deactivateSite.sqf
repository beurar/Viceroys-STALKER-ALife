/*
    Deactivates the anomaly field at the given registry index.
*/

["anomalies_deactivateSite"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
params ["_index"];

if (isNil "STALKER_anomalyFields") exitWith {};
if (_index < 0 || {_index >= count STALKER_anomalyFields}) exitWith {};

private _entry = STALKER_anomalyFields select _index;
_entry params ["_center","_anchor","_radius","_fn","_count","_objs","_marker","_site","_exp","_stable",["_active",false]];

if ((count _objs) > 0) then {
    { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
    _objs = [];
};
if (_marker != "") then {
    _marker setMarkerBrushLocal "Border";
    _marker setMarkerAlpha 0.2;
};

_active = false;
STALKER_anomalyFields set [_index, [_center,_anchor,_radius,_fn,_count,_objs,_marker,_site,_exp,_stable,_active]];

true
