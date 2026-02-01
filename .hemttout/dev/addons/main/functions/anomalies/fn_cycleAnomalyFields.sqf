/*
    Reshuffles stable anomaly fields and relocates unstable ones.
    Called when an emission ends or via debug action.
*/

["cycleAnomalyFields"] call VIC_fnc_debugLog;

if (isServer && !isNil "STALKER_anomalyFields") then {
    private _dur = missionNamespace getVariable ["STALKER_AnomalyFieldDuration", 30];
    for "_i" from 0 to ((count STALKER_anomalyFields) - 1) do {
        private _entry = STALKER_anomalyFields select _i;
        _entry params ["_center","_anchor","_radius","_fn","_count","_objs","_marker","_site","_exp","_stable"];
        { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
        if (_marker != "") then {
            deleteMarker _marker;
            if (!isNil "STALKER_anomalyMarkers") then {
                private _idx = STALKER_anomalyMarkers find _marker;
                if (_idx >= 0) then { STALKER_anomalyMarkers deleteAt _idx; };
            };
        };
        _objs = [];
        if (!_stable) then {
            _center = [random worldSize, random worldSize, 0];
            _site = [];
        };
        private _spawned = [_center,_radius,_count,_site] call _fn;
        if (!(_spawned isEqualTo [])) then {
            _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
            _site = getMarkerPos _marker;
            _objs = _spawned;
            if (_marker != "") then { _marker setMarkerBrushLocal "Border"; _marker setMarkerAlpha 1; };
            if (_stable && {_marker != ""}) then {
                private _type = switch (_fn) do {
                    case VIC_fnc_createField_burner: {"burner"};
                    case VIC_fnc_createField_electra: {"electra"};
                    case VIC_fnc_createField_fruitpunch: {"fruitpunch"};
                    case VIC_fnc_createField_springboard: {"springboard"};
                    case VIC_fnc_createField_gravi: {"gravi"};
                    case VIC_fnc_createField_meatgrinder: {"meatgrinder"};
                    case VIC_fnc_createField_whirligig: {"whirligig"};
                    case VIC_fnc_createField_clicker: {"clicker"};
                    case VIC_fnc_createField_launchpad: {"launchpad"};
                    case VIC_fnc_createField_leech: {"leech"};
                    case VIC_fnc_createField_trapdoor: {"trapdoor"};
                    case VIC_fnc_createField_zapper: {"zapper"};
                    default {""};
                };
                _marker setMarkerText ([_type, _site] call VIC_fnc_generateFieldName);
            };
        };
        _exp = diag_tickTime + (_dur * 60);
        STALKER_anomalyFields set [_i, [_center,_anchor,_radius,_fn,_count,_objs,_marker,_site,_exp,_stable]];
    };
};

true

