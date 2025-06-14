/*
    Marks detected building clusters on the map when debugging is enabled.

    Returns: BOOL
*/

["markBuildingClusters"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };

if (isNil "STALKER_buildingClusterMarkers") then { STALKER_buildingClusterMarkers = [] };

// Remove existing markers
{
    if (_x != "") then { deleteMarker _x };
} forEach STALKER_buildingClusterMarkers;
STALKER_buildingClusterMarkers = [];

private _clusters = [] call VIC_fnc_findBuildingClusters;

{
    {
        private _pos = getPosATL _x;
        private _name = format ["bcl_%1", diag_tickTime + random 1000];
        private _marker = createMarker [_name, _pos];
        _marker setMarkerShape "ICON";
        _marker setMarkerType "mil_dot";
        _marker setMarkerColor "ColorBlue";
        STALKER_buildingClusterMarkers pushBack _marker;
    } forEach _x;
} forEach _clusters;

true
