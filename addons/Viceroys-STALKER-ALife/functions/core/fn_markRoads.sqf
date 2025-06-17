/*
    Finds road positions via grid search and marks them on the map for debugging.

    Returns: BOOL
*/

["markRoads"] call VIC_fnc_debugLog;

if (isNil "STALKER_roadMarkers") then { STALKER_roadMarkers = [] };

// Remove any existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_roadMarkers;
STALKER_roadMarkers = [];

private _roads = [] call VIC_fnc_findRoads;

{
    private _name = format ["road_%1_%2", diag_tickTime, _forEachIndex];
    private _mkr = [_name, _x, "ICON", "mil_dot", "ColorOrange"] call VIC_fnc_createGlobalMarker;
    STALKER_roadMarkers pushBack _mkr;
} forEach _roads;

true
