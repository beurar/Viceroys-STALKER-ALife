/*
    Creates map markers on every building found in the mission when debugging is enabled.
    Each marker is labeled with the building's class name.

    Returns: BOOL
*/

["markAllBuildings"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

if (isNil "STALKER_buildingMarkers") then { STALKER_buildingMarkers = [] };

{
    private _type = typeOf _x;
    private _pos = getPosATL _x;
    private _name = format ["bld_%1_%2", toLower _type, diag_tickTime + random 1000];
    private _marker = createMarker [_name, _pos];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "mil_dot";
    _marker setMarkerColor "ColorYellow";
    _marker setMarkerText _type;
    STALKER_buildingMarkers pushBack _marker;
} forEach (allMissionObjects "building");

true
