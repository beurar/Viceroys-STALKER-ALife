/*
    Spawns a Chemical Warfare Plus contamination zone at the given
    position. The created zone will be automatically removed after the
    duration configured by `STALKER_radiationZoneDuration` (in seconds).

    Params:
        0: POSITION - center of the contamination area.
        1: NUMBER   - radius of the zone in meters (default: 50).

    Returns:
        ANY - handle returned by the CWP creation function.
*/

params [
    ["_position", [0,0,0]],
    ["_radius", 50]
];

// Array to keep track of active zones and their expiration times
if (isNil "STALKER_radiationZones") then {
    STALKER_radiationZones = [];
};

// Fallback to fifteen minutes if the mission maker has not set a value
private _duration = missionNamespace getVariable [
    "STALKER_radiationZoneDuration",
    900
];

// Spawn the zone using Chemical Warfare Plus. The mod is expected to
// provide `CWP_fnc_createZone` which returns a zone handle that can be
// later passed to `CWP_fnc_removeZone` for cleanup.
private _zoneHandle = [
    _position,
    _radius
] call CWP_fnc_createZone;

// Record the zone and when it should be removed
STALKER_radiationZones pushBack [
    _zoneHandle,
    diag_tickTime + _duration
];

_zoneHandle
