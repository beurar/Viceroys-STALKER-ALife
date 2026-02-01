/*
    Marks all detected sniper spots on the map when debugging is enabled.

    Returns: BOOL
*/


params [["_global", false]];

["markSniperSpots"] call VIC_fnc_debugLog;


if (isNil "STALKER_sniperSpotMarkers") then { STALKER_sniperSpotMarkers = [] };

// Remove existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_sniperSpotMarkers;
STALKER_sniperSpotMarkers = [];

if (isNil "STALKER_sniperSpots") exitWith { false };
private _spots = STALKER_sniperSpots;

{
    private _name = format ["sniper_%1_%2", diag_tickTime, _forEachIndex];
    private _marker = [_name, _x, "ICON", "mil_ambush", "#(0,0,1,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
    STALKER_sniperSpotMarkers pushBack _marker;
} forEach _spots;

true
