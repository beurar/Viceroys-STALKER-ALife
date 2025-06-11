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
    _marker setMarkerColor "ColorGreen";
    _marker setMarkerSize [150,150];
    private _max = switch (_type) do {
        case "Bloodsucker": { ["VSA_habitatSize_Bloodsucker",12] call VIC_fnc_getSetting };
        case "Blind Dog": { ["VSA_habitatSize_Dog",50] call VIC_fnc_getSetting };
        case "Pseudodog": { ["VSA_habitatSize_Dog",50] call VIC_fnc_getSetting };
        case "Boar": { ["VSA_habitatSize_Boar",10] call VIC_fnc_getSetting };
        case "Cat": { ["VSA_habitatSize_Cat",10] call VIC_fnc_getSetting };
        case "Flesh": { ["VSA_habitatSize_Flesh",10] call VIC_fnc_getSetting };
        case "Controller": { ["VSA_habitatSize_Controller",8] call VIC_fnc_getSetting };
        case "Pseudogiant": { ["VSA_habitatSize_Pseudogiant",6] call VIC_fnc_getSetting };
        case "Izlom": { ["VSA_habitatSize_Izlom",10] call VIC_fnc_getSetting };
        default {10};
    };
    _marker setMarkerText format ["%1 Habitat: 0/%2", _type, _max];
    STALKER_mutantHabitats pushBack [_marker, grpNull, _pos, _type, _max];
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
