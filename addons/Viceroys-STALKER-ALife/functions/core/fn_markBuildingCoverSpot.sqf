/*
    Marks a hidden spot behind a nearby building on the map when debugging.

    Returns: BOOL
*/


params [["_global", false]];

["markBuildingCoverSpot"] call VIC_fnc_debugLog;


if (isNil "STALKER_coverMarkers") then { STALKER_coverMarkers = [] };

{ if (_x != "") then { deleteMarker _x } } forEach STALKER_coverMarkers;
STALKER_coverMarkers = [];

private _pos = [player] call VIC_fnc_findBuildingCoverSpot;
if (isNil {_pos}) exitWith { false };

private _name = format ["cover_%1", diag_tickTime + random 1000];
private _marker = [_name, _pos, "ICON", "mil_objective", "#(0,1,0,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
STALKER_coverMarkers pushBack _marker;

true
