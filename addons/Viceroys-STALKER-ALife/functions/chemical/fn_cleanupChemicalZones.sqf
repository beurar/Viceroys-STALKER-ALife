/*
    Removes expired Chemical Warfare Plus gas zones.
    Zones are stored in `STALKER_chemicalZones` with their expiration
    time as recorded by `fn_spawnChemicalZone`.

    Params:
        0: BOOLEAN - force removal regardless of expiry (default: false)
*/

params [["_force", false]];

["cleanupChemicalZones"] call VIC_fnc_debugLog;

if (isNil "STALKER_chemicalZones") exitWith {};

private _now = diag_tickTime;

for [{_i = (count STALKER_chemicalZones) - 1}, {_i >= 0}, {_i = _i - 1}] do {
    private _entry = STALKER_chemicalZones select _i;
    private _zone  = _entry select 0;
    private _marker = _entry select 1;
    private _expires = _entry select 2;

    if (_force || { _expires >= 0 && _now > _expires }) then {
        if (!isNull _zone) then { deleteVehicle _zone; };
        if (!isNil {_marker}) then { deleteMarker _marker; };
        STALKER_chemicalZones deleteAt _i;
    };
};

true
