/*
    Marks all detected rock clusters on the map when debugging is enabled.

    Returns: BOOL
*/

["markRockClusters"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };

if (isNil "STALKER_rockClusterMarkers") then { STALKER_rockClusterMarkers = [] };

// Remove existing markers if present
{
    if (_x != "") then { deleteMarker _x }; 
} forEach STALKER_rockClusterMarkers;
STALKER_rockClusterMarkers = [];

private _clusters = [] call VIC_fnc_findRockClusters;

{
    {
        private _pos = getPosATL _x;
        private _name = format ["rock_%1", diag_tickTime + random 1000];
        private _marker = createMarker [_name, _pos];
        _marker setMarkerShape "ICON";
        _marker setMarkerType "mil_dot";
        _marker setMarkerColor "ColorBlack";
        STALKER_rockClusterMarkers pushBack _marker;
    } forEach _x;
} forEach _clusters;

true
