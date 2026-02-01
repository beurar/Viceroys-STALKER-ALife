/*
    Activates or deactivates chemical zones based on player proximity
    and removes expired entries. Zones are stored in
    STALKER_chemicalZones as [position, radius, active, marker, expires].
*/

// ["manageChemicalZones"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_chemicalZones") exitWith {};

private _range = missionNamespace getVariable ["STALKER_activityRadius", 1500];

for [{_i = (count STALKER_chemicalZones) - 1}, {_i >= 0}, {_i = _i - 1}] do {
    private _entry = STALKER_chemicalZones select _i;
    _entry params ["_pos","_radius","_active","_marker","_expires"];

    if (_expires >= 0 && {diag_tickTime > _expires}) then {
        if (_marker != "") then { deleteMarker _marker; };
        STALKER_chemicalZones deleteAt _i;
        continue;
    };

    private _newActive = [_pos,_range,_active] call VIC_fnc_evalSiteProximity;
    if (_newActive) then {
        if (!_active) then {
            private _dur = if (_expires < 0) then {-1} else {_expires - diag_tickTime};
            [_pos,_radius,_dur] call VIC_fnc_spawnChemicalZone;
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if (_active) then { _active = false; };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };
    _active = _newActive;

    STALKER_chemicalZones set [_i, [_pos,_radius,_active,_marker,_expires]];
};

true
