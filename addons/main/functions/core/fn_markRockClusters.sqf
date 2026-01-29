/*
    Marks all detected rock clusters on the map when debugging is enabled.

    Returns: BOOL
*/



params [["_global", false]];

["markRockClusters"] call VIC_fnc_debugLog;


if (isNil "STALKER_rockClusterMarkers") then { STALKER_rockClusterMarkers = [] };

// Remove existing markers if present
{
    if (_x != "") then { deleteMarker _x }; 
} forEach STALKER_rockClusterMarkers;
STALKER_rockClusterMarkers = [];

if (isNil "STALKER_rockClusters") exitWith { false };
private _clusters = STALKER_rockClusters;

{
    {
        private _pos = getPosATL _x;
        private _name = format ["rock_%1", diag_tickTime + random 1000];
        private _marker = [_name, _pos, "ICON", "mil_box", "#(0,0,0,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
        STALKER_rockClusterMarkers pushBack _marker;
    } forEach _x;
} forEach _clusters;

true
