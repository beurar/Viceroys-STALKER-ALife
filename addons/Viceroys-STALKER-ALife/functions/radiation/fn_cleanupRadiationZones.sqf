/*
    Removes expired Chemical Warfare Plus contamination zones.
    The zones are stored in `STALKER_radiationZones` with their
    expiration time as returned by `fn_spawnRadiationZone`.

    This function should be called periodically, e.g. from a scheduler
    that runs after emissions.
*/

["cleanupRadiationZones"] call VIC_fnc_debugLog;

if (isNil "STALKER_radiationZones") exitWith {};

private _now = diag_tickTime;

for [{_i = (count STALKER_radiationZones) - 1}, {_i >= 0}, {_i = _i - 1}] do {
    private _entry = STALKER_radiationZones select _i;
    private _zoneHandle = _entry select 0;
    private _marker = _entry select 1;
    private _expires = _entry select 2;

    if (_now > _expires) then {
        // Delete the zone using the Chemical Warfare Plus function
        [_zoneHandle] call CWP_fnc_removeZone;

        if (!isNil {_marker}) then { deleteMarker _marker; };

        STALKER_radiationZones deleteAt _i;
    };
};

true
