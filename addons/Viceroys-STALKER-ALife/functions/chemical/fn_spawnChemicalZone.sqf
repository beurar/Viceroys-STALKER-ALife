/*
    Spawns a Chemical Warfare Plus gas zone at the given position.
    The zone uses the Asphyxiant gas type and lasts for three hours
    by default.

    Params:
        0: POSITION - center of the gas cloud
        1: NUMBER   - radius of the zone in meters (default: 50)
        2: NUMBER   - duration in seconds (optional, defaults to 10800)

    Returns:
        OBJECT - handle to the spawned module
*/

params [
    ["_position", [0,0,0]],
    ["_radius", 50],
    ["_duration", -1]
];

["spawnChemicalZone"] call VIC_fnc_debugLog;

// Array to keep track of active zones and their expiration times
if (isNil "STALKER_chemicalZones") then {
    STALKER_chemicalZones = [];
};

if (_duration < 0) then {
    _duration = 10800; // default to three hours
};

// Create the module that spawns the gas cloud
private _module = "PHEN_CWPLUS_ModuleSpawnCSGas" createVehicle _position;
_module setVariable ["CBRN_Radius", _radius, true];
_module setVariable ["CBRN_Lifetime", _duration, true];
_module setVariable ["CBRN_Thickness", 1, true];
_module setVariable ["CBRN_ChemType", 1, true]; // Asphyxiant gas
[
    "init",
    _module
] call CBRN_fnc_ModuleSpawnCSGas;

// Create and configure a map marker for this chemical zone
private _markerName = format ["chem_%1", diag_tickTime];
private _marker = createMarker [_markerName, _position];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [_radius, _radius];
_marker setMarkerColor "ColorGreen";
_marker setMarkerText format ["Chemical %1m", _radius];

// Record the zone and when it should be removed
private _expires = -1;
if (_duration >= 0) then {
    _expires = diag_tickTime + _duration;
};

STALKER_chemicalZones pushBack [
    _module,
    _marker,
    _expires
];

_module
