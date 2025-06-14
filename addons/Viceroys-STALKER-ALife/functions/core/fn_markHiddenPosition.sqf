/*
    Marks a hidden position near players on the map when debugging is enabled.

    Returns: BOOL
*/

["markHiddenPosition"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };

if (isNil "STALKER_hiddenMarkers") then { STALKER_hiddenMarkers = [] };

// remove existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_hiddenMarkers;
STALKER_hiddenMarkers = [];

private _pos = [] call VIC_fnc_findHiddenPosition;
if (isNil "_pos") exitWith { false };

private _name = format ["hidden_%1", diag_tickTime + random 1000];
private _marker = createMarker [_name, _pos];
_marker setMarkerShape "ICON";
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorGreen";
STALKER_hiddenMarkers pushBack _marker;

true
