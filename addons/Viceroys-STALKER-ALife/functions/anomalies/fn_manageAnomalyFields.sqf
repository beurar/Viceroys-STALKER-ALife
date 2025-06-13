/*
    Activates or deactivates anomaly fields based on player proximity and
    removes expired entries.
    STALKER_anomalyFields entries:
        [center, radius, fn, count, objects, marker, site, expires, permanent]
*/
["manageAnomalyFields"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_anomalyFields") exitWith {};

for [{_i = (count STALKER_anomalyFields) - 1}, {_i >= 0}, {_i = _i - 1}] do {
    private _entry = STALKER_anomalyFields select _i;
    _entry params ["_center","_radius","_fn","_count","_objs","_marker","_site","_exp","_perm"];

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

    private _pos = if (_site isEqualTo []) then {_center} else {_site};
    private _dist = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;
    private _near = [_pos,_dist] call VIC_fnc_hasPlayersNearby;

    if (_near) then {
        if (_objs isEqualTo []) then {
            private _spawned = [_center,_radius,_count,_site] call _fn;
            if (!(_spawned isEqualTo [])) then {
                _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
                _site = getMarkerPos _marker;
                _objs = _spawned;
            };
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if (_objs isNotEqualTo []) then {
            { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
            _objs = [];
        };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };
    STALKER_anomalyFields set [_i, [_center,_radius,_fn,_count,_objs,_marker,_site,_exp,_perm]];
};

true
