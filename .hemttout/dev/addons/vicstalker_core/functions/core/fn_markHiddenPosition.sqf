/*
    Marks a hidden position near players on the map when debugging is enabled.

    Returns: BOOL
*/


params [["_global", false]];

["markHiddenPosition"] call VIC_fnc_debugLog;


if (isNil "STALKER_hiddenMarkers") then { STALKER_hiddenMarkers = [] };

// remove existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_hiddenMarkers;
STALKER_hiddenMarkers = [];

private _pos = [] call VIC_fnc_findHiddenPosition;
if (isNil {_pos}) exitWith { false };

private _name = format ["hidden_%1", diag_tickTime + random 1000];
private _marker = [_name, _pos, "ICON", "mil_ambush", "#(0,1,0,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
STALKER_hiddenMarkers pushBack _marker;

true
