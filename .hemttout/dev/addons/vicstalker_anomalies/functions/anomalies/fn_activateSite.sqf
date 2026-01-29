/*
    Activates the anomaly field at the given registry index.
*/

["anomalies_activateSite"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
params ["_index"];

if (isNil "STALKER_anomalyFields") exitWith {};
if (_index < 0 || {_index >= count STALKER_anomalyFields}) exitWith {};

private _entry = STALKER_anomalyFields select _index;
_entry params ["_center","_anchor","_radius","_fn","_count","_objs","_marker","_site","_exp","_stable",["_active",false]];

if (_objs isEqualTo [] || {{isNull _x} count _objs == count _objs}) then {
    private _spawned = [_center,_radius,_count,_site] call _fn;
    if (_spawned isNotEqualTo []) then {
        _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
        _site = getMarkerPos _marker;
        _objs = _spawned;
    } else {
        _objs = [];
    };
} else {
    _objs = _objs select { !isNull _x };
};
if (_marker != "") then {
    _marker setMarkerBrushLocal "Border";
    _marker setMarkerAlpha 1;
};

_active = true;
STALKER_anomalyFields set [_index, [_center,_anchor,_radius,_fn,_count,_objs,_marker,_site,_exp,_stable,_active]];

true
