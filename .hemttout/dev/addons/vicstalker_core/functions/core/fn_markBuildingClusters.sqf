/*
    Marks detected building clusters on the map when debugging is enabled.

    Returns: BOOL
*/


params [["_global", false]];

["markBuildingClusters"] call VIC_fnc_debugLog;


if (isNil "STALKER_buildingClusterMarkers") then { STALKER_buildingClusterMarkers = [] };

// Remove existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_buildingClusterMarkers;
STALKER_buildingClusterMarkers = [];

if (isNil "STALKER_buildingClusters") exitWith { false };
private _clusters = STALKER_buildingClusters;

{
    {
        private _pos = _x;
        private _name = format ["bcl_%1", diag_tickTime + random 1000];
        private _marker = [_name, _pos, "ICON", "mil_objective", "#(0,0,1,1)", 1, "", [1,1], _global] call VIC_fnc_createGlobalMarker;
        STALKER_buildingClusterMarkers pushBack _marker;
    } forEach _x;
} forEach _clusters;

true
