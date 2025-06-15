/*
    Marks a hidden spot behind a nearby building on the map when debugging.

    Returns: BOOL
*/

["markBuildingCoverSpot"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };

if (isNil "STALKER_coverMarkers") then { STALKER_coverMarkers = [] };

{ if (_x != "") then { deleteMarker _x } } forEach STALKER_coverMarkers;
STALKER_coverMarkers = [];

private _pos = [player] call VIC_fnc_findBuildingCoverSpot;
if (isNil {_pos}) exitWith { false };

private _name = format ["cover_%1", diag_tickTime + random 1000];
private _marker = createMarker [_name, _pos];
_marker setMarkerShape "ICON";
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorGreen";
STALKER_coverMarkers pushBack _marker;

true
