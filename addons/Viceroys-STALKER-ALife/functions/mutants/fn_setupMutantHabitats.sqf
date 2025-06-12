/*
    Generates simple habitat markers for various mutant types.
    This runs on the server during postInit.
*/

["setupMutantHabitats"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (isNil "STALKER_mutantHabitats") then { STALKER_mutantHabitats = []; };

private _createMarker = {
    params ["_type", "_pos"];
    private _base = format ["hab_%1_%2", toLower _type, diag_tickTime + random 1000];

    private _area = createMarker [_base + "_area", _pos];
    _area setMarkerShape "ELLIPSE";
    _area setMarkerColor "ColorGreen";
    _area setMarkerSize [150,150];

    private _label = createMarker [_base + "_label", _pos];
    _label setMarkerShape "ICON";
    _label setMarkerType "mil_dot";
    _label setMarkerColor "ColorGreen";
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

    _label setMarkerText format ["%1 Habitat: %2/%2", _type, _max];
    STALKER_mutantHabitats pushBack [_area, _label, grpNull, _pos, _type, _max, _max];
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
