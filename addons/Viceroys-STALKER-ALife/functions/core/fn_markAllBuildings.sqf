/*
    Creates map markers on every building found in the mission when debugging is enabled.
    Each marker is labeled with the building's class name.

    Returns: BOOL
*/

["markAllBuildings"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith { false };

if (isNil "STALKER_buildingMarkers") then { STALKER_buildingMarkers = [] };

// Collect mission placed buildings and terrain buildings
private _center = [worldSize / 2, worldSize / 2, 0];
private _buildings = nearestObjects [_center, ["House"], worldSize];
_buildings append (allMissionObjects "building");
_buildings = _buildings arrayIntersect _buildings; // remove duplicates

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
} forEach _buildings;

true
