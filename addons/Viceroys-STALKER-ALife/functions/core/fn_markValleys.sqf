/*
    Marks detected valley positions on the map when debugging is enabled.

    Returns: BOOL
*/

["markValleys"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };

if (isNil "STALKER_valleyMarkers") then { STALKER_valleyMarkers = [] };

// Remove any existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_valleyMarkers;
STALKER_valleyMarkers = [];

private _valleys = [] call VIC_fnc_findValleys;

{
    private _pos = _x;
    private _name = format ["valley_%1", diag_tickTime + random 1000];
    private _marker = createMarker [_name, _pos];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "mil_triangle";
    _marker setMarkerColor "ColorBlue";
    STALKER_valleyMarkers pushBack _marker;
} forEach _valleys;

true
