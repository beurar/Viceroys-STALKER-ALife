/*
    Finds road positions via grid search and marks them on the map for debugging.

    Returns: BOOL
*/


params [["_global", false]];

["markRoads"] call VIC_fnc_debugLog;

if (isNil "STALKER_roadMarkers") then { STALKER_roadMarkers = [] };
if (isNil "STALKER_crossroadMarkers") then { STALKER_crossroadMarkers = [] };

// Remove any existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_roadMarkers;
STALKER_roadMarkers = [];
{ if (_x != "") then { deleteMarker _x }; } forEach STALKER_crossroadMarkers;
STALKER_crossroadMarkers = [];

if (isNil "STALKER_roads") exitWith { false };
private _roads = STALKER_roads;
private _crossroads = [];
if (!isNil "STALKER_crossroads") then { _crossroads = STALKER_crossroads; };

{
    private _name = format ["road_%1_%2", diag_tickTime, _forEachIndex];
    private _mkr = [_name, _x, "ICON", "mil_dot", "#(1,0.5,0,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
    STALKER_roadMarkers pushBack _mkr;
} forEach _roads;

{
    private _name = format ["crossroad_%1_%2", diag_tickTime, _forEachIndex];
    private _mkr = [_name, _x, "ICON", "mil_join", "#(1,0,0,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
    STALKER_crossroadMarkers pushBack _mkr;
} forEach _crossroads;

true
