/*
    Activates or deactivates chemical zones based on player proximity
    and removes expired entries. Zones are stored in
    STALKER_chemicalZones as [position, radius, module, marker, expires].
*/

["manageChemicalZones"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_chemicalZones") exitWith {};

private _range = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;

for [{_i = (count STALKER_chemicalZones) - 1}, {_i >= 0}, {_i = _i - 1}] do {
    private _entry = STALKER_chemicalZones select _i;
    _entry params ["_pos","_radius","_zone","_marker","_expires"];

    if (_expires >= 0 && {diag_tickTime > _expires}) then {
        if (!isNull _zone) then { deleteVehicle _zone; };
        if (_marker != "") then { deleteMarker _marker; };
        STALKER_chemicalZones deleteAt _i;
        continue;
    };

    private _near = [_pos,_range] call VIC_fnc_hasPlayersNearby;
    if (_near) then {
        if (isNull _zone) then {
            private _dur = if (_expires < 0) then {-1} else {_expires - diag_tickTime};
            _zone = [_pos,_radius,_dur] call VIC_fnc_spawnChemicalZone;
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if (!isNull _zone) then { deleteVehicle _zone; _zone = objNull; };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };

    STALKER_chemicalZones set [_i, [_pos,_radius,_zone,_marker,_expires]];
};

true
