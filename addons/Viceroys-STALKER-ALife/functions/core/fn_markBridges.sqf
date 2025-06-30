/*
    Marks all detected bridges on the map when debugging is enabled.

    Returns: BOOL
*/


params [["_global", false]];

["markBridges"] call VIC_fnc_debugLog;

if (isNil "STALKER_bridgeMarkers") then { STALKER_bridgeMarkers = [] };

// Remove existing markers if present
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_bridgeMarkers;
STALKER_bridgeMarkers = [];

if (isNil "STALKER_bridges") exitWith { false };
private _bridges = STALKER_bridges;

{
    private _type = typeOf _x;
    private _pos = getPosATL _x;
    private _name = format ["bridge_%1_%2", toLower _type, diag_tickTime + random 1000];
    private _marker = [_name, _pos, "ICON", "mil_box", "#(1,0,0,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
    [_name, _type] remoteExecCall ["setMarkerText", 0, true];
    STALKER_bridgeMarkers pushBack _marker;
} forEach _bridges;

true
