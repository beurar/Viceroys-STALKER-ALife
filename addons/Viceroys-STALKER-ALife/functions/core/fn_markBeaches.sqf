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

private _beachSpots = [] call compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\core\fn_findBeachesInMap.sqf";

{
    private _mkr = createMarkerLocal [format ["beach_%1", diag_tickTime], _x];
    _mkr setMarkerTypeLocal "mil_circle";
    _mkr setMarkerColorLocal "ColorYellow";
    _mkr setMarkerSizeLocal [0.7, 0.7];
    STALKER_beachMarkers pushBack _mkr;
} forEach _beachSpots;

true
