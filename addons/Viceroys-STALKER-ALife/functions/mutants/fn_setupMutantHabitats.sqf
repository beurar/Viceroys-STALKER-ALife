/*
    Generates simple habitat markers for various mutant types.
    This runs on the server during postInit.
*/

["setupMutantHabitats"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (isNil "STALKER_mutantHabitats") then { STALKER_mutantHabitats = []; };

private _createMarker = {
    params ["_type", "_pos"];
    private _name = format ["hab_%1_%2", toLower _type, diag_tickTime + random 1000];
    private _marker = createMarker [_name, _pos];
    _marker setMarkerShape "ELLIPSE";
    // Dark green markers caused confusion with players, use standard green instead
    _marker setMarkerColor "ColorGreen";
    _marker setMarkerSize [150,150];
    _marker setMarkerText format ["Habitat: %1", toUpper _type];
    STALKER_mutantHabitats pushBack [_marker, _type];
};

private _center = [worldSize/2, worldSize/2, 0];
private _locations = nearestLocations [_center, [], worldSize];

{
    private _pos = locationPosition _x;
    private _type = switch (type _x) do {
        case "NameCity": {"Controller"};
        case "NameCityCapital": {"Pseudogiant"};
        case "NameVillage": {selectRandom ["Blind Dog","Izlom","Bloodsucker","Pseudodog"]};
        case "Hill": {selectRandom ["Boar","Cat","Flesh"]};
        default {""};
    };
    if (_type != "") then {
        [_type, _pos] call _createMarker;
    };
} forEach _locations;

true
