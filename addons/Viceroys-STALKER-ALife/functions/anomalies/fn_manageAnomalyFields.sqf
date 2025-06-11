/*
    Activates or deactivates anomaly fields based on player proximity.
    STALKER_anomalyFields entries: [center, radius, fn, count, objects, marker, site]
*/
["manageAnomalyFields"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_anomalyFields") exitWith {};

{
    _x params ["_center","_radius","_fn","_count","_objs","_marker","_site"];
    private _pos = if (_site isEqualTo []) then {_center} else {_site};
    private _near = [_pos,1500] call VIC_fnc_hasPlayersNearby;

    if (_near) then {
        if (_objs isEqualTo []) then {
            private _spawned = [_center,_radius,_count,_pos] call _fn;
            if (!(_spawned isEqualTo [])) then {
                _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
                _site = getMarkerPos _marker;
                _objs = _spawned;
            };
        };
    } else {
        if (_objs isNotEqualTo []) then {
            { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
            if (_marker != "") then {
                deleteMarker _marker;
                if (!isNil "STALKER_anomalyMarkers") then {
                    private _idx = STALKER_anomalyMarkers find _marker;
                    if (_idx >= 0) then { STALKER_anomalyMarkers deleteAt _idx; };
                };
            };
            _objs = [];
            _marker = "";
        };
    };
    STALKER_anomalyFields set [_forEachIndex, [_center,_radius,_fn,_count,_objs,_marker,_site]];
} forEach STALKER_anomalyFields;

true
