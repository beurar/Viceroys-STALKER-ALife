/*
    Marks all detected sniper spots on the map when debugging is enabled.

    Returns: BOOL
*/

["markSniperSpots"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };

if (isNil "STALKER_sniperSpotMarkers") then { STALKER_sniperSpotMarkers = [] };

// Remove existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_sniperSpotMarkers;
STALKER_sniperSpotMarkers = [];

private _spots = [] call VIC_fnc_findSniperSpots;

{
    private _name = format ["sniper_%1_%2", diag_tickTime, _forEachIndex];
    private _marker = createMarker [_name, _x];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "mil_dot";
    _marker setMarkerColor "ColorBlue";
    STALKER_sniperSpotMarkers pushBack _marker;
} forEach _spots;

true
