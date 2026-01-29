/*
    Marks cached land zones on the map when debugging is enabled.

    Returns: BOOL
*/


params [["_global", false]];

["markLandZones"] call VIC_fnc_debugLog;

if (isNil "STALKER_landZoneMarkers") then { STALKER_landZoneMarkers = [] };

// Remove existing markers if present
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_landZoneMarkers;
STALKER_landZoneMarkers = [];

if (isNil "STALKER_landZones") then {
    private _cached = ["STALKER_landZones"] call VIC_fnc_loadCache;
    if (isNil {_cached}) exitWith { false };
    STALKER_landZones = _cached;
};
private _zones = STALKER_landZones;

{
    private _name = format ["landzone_%1", diag_tickTime + random 1000];
    private _mkr = [_name, _x, "ICON", "mil_pickup", "#(1,1,0,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
    STALKER_landZoneMarkers pushBack _mkr;
} forEach _zones;

[format ["markLandZones: placed %1 markers", count _zones]] call VIC_fnc_debugLog;

true
