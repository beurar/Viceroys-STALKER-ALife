/*
    Marks all detected swamp areas on the map when debugging is enabled.

    Returns: BOOL
*/


params [["_global", false]];

["markSwamps"] call VIC_fnc_debugLog;


if (isNil "STALKER_swampMarkers") then { STALKER_swampMarkers = [] };

// Remove existing markers if present
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_swampMarkers;
STALKER_swampMarkers = [];

if (isNil "STALKER_swamps") exitWith { false };
private _swamps = STALKER_swamps;

{
    private _pos = _x;
    private _name = format ["swamp_%1", diag_tickTime + random 1000];
    private _marker = [_name, _pos, "ICON", "mil_warning", "#(0,0.5,0,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
    STALKER_swampMarkers pushBack _marker;
} forEach _swamps;

true
