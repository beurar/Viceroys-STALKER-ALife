/*
    Marks cached wreck positions on the map when debugging is enabled.

    Returns: BOOL
*/


params [["_global", false]];

["markWrecks"] call VIC_fnc_debugLog;

if (isNil "STALKER_wreckMarkers") then { STALKER_wreckMarkers = [] };

// Remove any existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_wreckMarkers;
STALKER_wreckMarkers = [];

if (isNil "STALKER_wrecks") then { STALKER_wrecks = [] };

{
    private _pos = getPosATL _x;
    private _name = format ["wreck_%1_%2", diag_tickTime, _forEachIndex];
    private _marker = [_name, _pos, "ICON", "mil_warning", "#(0.3,0.3,0.3,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
    STALKER_wreckMarkers pushBack _marker;
} forEach STALKER_wrecks;

true

