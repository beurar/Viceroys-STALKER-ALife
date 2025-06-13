/*
    Placeholder called when an emission ends to allow anomalies to react.
*/

["anomalies_onEmissionEnd"] call VIC_fnc_debugLog;

if (isServer && !isNil "STALKER_anomalyFields") then {
    private _mode = ["VSA_anomalyEmissionMode",1] call VIC_fnc_getSetting;
    {
        _x params ["_center","_radius","_fn","_count","_objs","_marker","_site","_exp"];
        { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
        if (_marker != "") then {
            deleteMarker _marker;
            if (!isNil "STALKER_anomalyMarkers") then {
                private _idx = STALKER_anomalyMarkers find _marker;
                if (_idx >= 0) then { STALKER_anomalyMarkers deleteAt _idx; };
            };
        };
        _objs = [];
        if (_mode > 0) then {
            if (_mode == 2) then { _site = [] }; // replace
            private _spawned = [_center,_radius,_count,_site] call _fn;
            if (!(_spawned isEqualTo [])) then {
                _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
                _site = getMarkerPos _marker;
                _objs = _spawned;
            };
        };
        private _dur = missionNamespace getVariable ["STALKER_AnomalyFieldDuration", 30];
        _exp = diag_tickTime + (_dur * 60);
        STALKER_anomalyFields set [_forEachIndex, [_center,_radius,_fn,_count,_objs,_marker,_site,_exp]];
    } forEach STALKER_anomalyFields;
};

true
