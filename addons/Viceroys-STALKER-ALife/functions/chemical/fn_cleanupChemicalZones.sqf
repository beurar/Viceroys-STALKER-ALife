/*
    Removes expired chemical zone markers. The mist itself
    despawns automatically after its lifetime.
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
    _entry params ["_pos","_radius","_active","_marker","_expires"];

    if (_force || { _expires >= 0 && _now > _expires }) then {
        if (_marker != "") then { deleteMarker _marker; };
        STALKER_chemicalZones deleteAt _i;
    };
};

true
