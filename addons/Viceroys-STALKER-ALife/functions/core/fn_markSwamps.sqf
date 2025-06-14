/*
    Marks all detected swamp areas on the map when debugging is enabled.

    Returns: BOOL
*/

["markSwamps"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };

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
    private _marker = createMarker [_name, _pos];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "mil_triangle";
    _marker setMarkerColor "ColorGreen";
    STALKER_swampMarkers pushBack _marker;
} forEach _swamps;

true
