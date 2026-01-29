/*
    Marks potential beach spots on the map for debugging purposes.

    Returns: BOOL
*/

["markBeaches"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };

if (isNil "STALKER_beachMarkers") then { STALKER_beachMarkers = [] };

// Remove existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_beachMarkers;
STALKER_beachMarkers = [];

if (isNil "STALKER_beachSpots") exitWith { false };
private _beachSpots = STALKER_beachSpots;

{
    private _mkr = createMarkerLocal [format ["beach_%1", diag_tickTime], _x];
    _mkr setMarkerTypeLocal "mil_start";
    _mkr setMarkerColorLocal "#(0,0.8,1,1)";
    _mkr setMarkerSizeLocal [0.7, 0.7];
    STALKER_beachMarkers pushBack _mkr;
} forEach _beachSpots;

true
