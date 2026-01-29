/*
    Spawns a chemical mist cloud using CBRN_fnc_spawnMist.
    The gas defaults to the Asphyxiant chemical index and lasts for
    three hours unless a different duration is provided.

    Params:
        0: POSITION - center of the gas cloud
        1: NUMBER   - radius of the zone in meters (default: 50)
        2: NUMBER   - duration in seconds (optional, defaults to 10800)
        3: NUMBER   - chemical index used by CBRN_fnc_spawnMist
                      (optional, defaults to 1 - Asphyxiant)

        4: NUMBER   - vertical spread of the mist (optional, default -0.1)
        5: NUMBER   - thickness of the mist (optional, default 1)

    // Gas Type IDs:
    // 0 - CS Gas
    // 1 - Asphyxiant
    // 2 - Nerve
    // 3 - Blister
    // 4 - Nova

    Returns:
        BOOLEAN - true when the zone was spawned
*/

params [
    ["_position", [0,0,0]],
    ["_radius", 50],
    ["_duration", -1],
    ["_chemType", -1],
    ["_verticleSpread", -0.1],
    ["_thickness", 1]
];

["spawnChemicalZone"] call VIC_fnc_debugLog;

// Array to keep track of active zones and their expiration times
if (isNil "STALKER_chemicalZones") then {
    STALKER_chemicalZones = [];
};

if (_chemType < 0) then {
    _chemType = ["VSA_chemicalGasType", 1] call VIC_fnc_getSetting;
};

if (_duration < 0) then {
    _duration = 10800; // default to three hours
};

// Convert the supplied position to AGL for the mist effect so it spawns
// directly on the ground regardless of the coordinate type passed in.
private _agl = ASLToAGL _position;

// Spawn the mist cloud across all machines
// Spawn the mist across all clients
if (isNil "CBRN_fnc_spawnMist") then {
    ["spawnChemicalZone: CBRN mod missing"] call VIC_fnc_debugLog;
} else {
    [_agl, _radius, _duration, _chemType, _verticleSpread, _thickness]
        remoteExec ["CBRN_fnc_spawnMist", 0];
};

// Create and configure a map marker for this chemical zone
private _markerName = format ["chem_%1", diag_tickTime];
private _atl = ASLToATL (AGLToASL _agl);
private _marker = _markerName;
[_marker, _atl, "ELLIPSE", "", VIC_colorGasYellow, 1, format ["Chemical %1m", _radius]] call VIC_fnc_createGlobalMarker;
[_marker, [_radius, _radius]] remoteExec ["setMarkerSize", 0];

// Record the zone and when it should be removed
private _expires = -1;
if (_duration >= 0) then {
    _expires = diag_tickTime + _duration;
};

STALKER_chemicalZones pushBack [
    _position,
    _radius,
    true,
    _marker,
    _expires
];

private _idx = (count STALKER_chemicalZones) - 1;

true;
