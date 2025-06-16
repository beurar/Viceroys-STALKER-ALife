/*
    Marks all detected swamp areas on the map when debugging is enabled.

    Returns: BOOL
*/

["markSwamps"] call VIC_fnc_debugLog;


if (isNil "STALKER_swampMarkers") then { STALKER_swampMarkers = [] };

// Remove existing markers if present
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_swampMarkers;
STALKER_swampMarkers = [];

private _swamps = [] call VIC_fnc_findSwamps;

{
    private _pos = _x;
    private _name = format ["swamp_%1", diag_tickTime + random 1000];
    private _marker = [_name, _pos, "ICON", "mil_triangle", "ColorGreen"] call VIC_fnc_createGlobalMarker;
    STALKER_swampMarkers pushBack _marker;
} forEach _swamps;

true
