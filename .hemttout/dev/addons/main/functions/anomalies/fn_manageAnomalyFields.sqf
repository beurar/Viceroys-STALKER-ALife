/*
    Activates or deactivates anomaly fields based on player proximity and
    removes expired entries.
    STALKER_anomalyFields entries:
        [center, anchor, radius, fn, count, objects, marker, site, expires, stable, active]
*/
// ["manageAnomalyFields"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_anomalyFields") exitWith {};

for "_i" from ((count STALKER_anomalyFields) - 1) to 0 step -1 do {
    private _entry = STALKER_anomalyFields select _i;
    _entry params ["_center","_anchor","_radius","_fn","_count","_objs","_marker","_site","_exp","_stable",["_active",false]];

    if (_exp >= 0 && {diag_tickTime > _exp}) then {
        { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
        if (_marker != "") then {
            deleteMarker _marker;
            if (!isNil "STALKER_anomalyMarkers") then {
                private _idx = STALKER_anomalyMarkers find _marker;
                if (_idx >= 0) then { STALKER_anomalyMarkers deleteAt _idx; };
            };
        };
        STALKER_anomalyFields deleteAt _i;
        continue;
    };

    private _dist = 400;
    private _newActive = [_anchor,_dist,_active] call VIC_fnc_evalSiteProximity;

    if (_newActive) then {
        if (!_active || {_objs isEqualTo [] || {{isNull _x} count _objs == count _objs}}) then {
            private _spawned = [_center,_radius,_count,_site] call _fn;
            if (!(_spawned isEqualTo [])) then {
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
    } else {
        if ((count _objs) > 0) then {
            { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
            _objs = [];
        };
        if (_marker != "") then {
            _marker setMarkerBrushLocal "Border";
            _marker setMarkerAlpha 0.2;
        };
    };
    STALKER_anomalyFields set [_i, [_center,_anchor,_radius,_fn,_count,_objs,_marker,_site,_exp,_stable,_newActive]];
};

true
