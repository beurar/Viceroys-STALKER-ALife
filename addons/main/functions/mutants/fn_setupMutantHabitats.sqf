/*
    Generates simple habitat markers for various mutant types.
    This runs on the server during postInit.
*/

["setupMutantHabitats"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (isNil "STALKER_mutantHabitats") then { STALKER_mutantHabitats = []; };
STALKER_mutantHabitatData = [];

private _createMarker = {
    params ["_type", "_pos"];

    if !( [_type] call VIC_fnc_isMutantEnabled ) exitWith { false };

    // Skip this location if it overlaps an existing habitat or anomaly field
    private _overlap = false;
    {
        if (_pos distance2D (_x#3) < 300) exitWith { _overlap = true };
    } forEach STALKER_mutantHabitats;
    if (!_overlap && {!isNil "STALKER_anomalyFields"}) then {
        {
            if (_pos distance2D (_x#7) < 300) exitWith { _overlap = true };
        } forEach STALKER_anomalyFields;
    };
    if (_overlap) exitWith { false };
    private _base = format ["hab_%1_%2", toLower _type, diag_tickTime + random 1000];

    private _area = _base + "_area";
    [_area, _pos, "ELLIPSE", "", VIC_colorMutant, 1, format ["%1 Habitat Area", _type]] call VIC_fnc_createGlobalMarker;
    [_area, [150,150]] remoteExec ["setMarkerSize", 0];

    private _label = _base + "_label";
    [_label, _pos, "ICON", "mil_dot", VIC_colorMutant, 1] call VIC_fnc_createGlobalMarker;
    private _max = switch (_type) do {
        case "Bloodsucker": { ["VSA_habitatSize_Bloodsucker",12] call VIC_fnc_getSetting };
        case "Blind Dog": { ["VSA_habitatSize_Dog",50] call VIC_fnc_getSetting };
        case "Pseudodog": { ["VSA_habitatSize_Dog",50] call VIC_fnc_getSetting };
        case "Snork": { ["VSA_habitatSize_Snork",12] call VIC_fnc_getSetting };
        case "Boar": { ["VSA_habitatSize_Boar",10] call VIC_fnc_getSetting };
        case "Cat": { ["VSA_habitatSize_Cat",10] call VIC_fnc_getSetting };
        case "Flesh": { ["VSA_habitatSize_Flesh",10] call VIC_fnc_getSetting };
        case "Controller": { ["VSA_habitatSize_Controller",8] call VIC_fnc_getSetting };
        case "Pseudogiant": { ["VSA_habitatSize_Pseudogiant",6] call VIC_fnc_getSetting };
        case "Izlom": { ["VSA_habitatSize_Izlom",10] call VIC_fnc_getSetting };
        case "Corruptor": { ["VSA_habitatSize_Corruptor",8] call VIC_fnc_getSetting };
        case "Smasher": { ["VSA_habitatSize_Smasher",8] call VIC_fnc_getSetting };
        case "Acid Smasher": { ["VSA_habitatSize_AcidSmasher",8] call VIC_fnc_getSetting };
        case "Behemoth": { ["VSA_habitatSize_Behemoth",6] call VIC_fnc_getSetting };
        case "Parasite": { ["VSA_habitatSize_Parasite",10] call VIC_fnc_getSetting };
        case "Jumper": { ["VSA_habitatSize_Jumper",10] call VIC_fnc_getSetting };
        case "Spitter": { ["VSA_habitatSize_Spitter",10] call VIC_fnc_getSetting };
        case "Stalker": { ["VSA_habitatSize_Stalker",10] call VIC_fnc_getSetting };
        case "Bully": { ["VSA_habitatSize_Bully",10] call VIC_fnc_getSetting };
        case "Hivemind": { ["VSA_habitatSize_Hivemind",10] call VIC_fnc_getSetting };
        case "Zombie": { ["VSA_habitatSize_Zombie",10] call VIC_fnc_getSetting };
        default {10};
    };

    _label setMarkerText format ["%1 Habitat: 0/%2", _type, _max];

    private _anchor = [_pos] call VIC_fnc_createProximityAnchor;

    STALKER_mutantHabitats pushBack [_area, _label, grpNull, _pos, _anchor, _type, _max, 0, false];
    STALKER_mutantHabitatData pushBack [_type, _pos, _max];
};

private _weightedPick = {
    params ["_list"];
    private _sum = 0;
    { _sum = _sum + (_x#1) } forEach _list;
    private _r = random _sum;
    private _acc = 0;
    private _sel = _list#0#0;
    {
        _acc = _acc + (_x#1);
        if (_r <= _acc) exitWith { _sel = _x#0 };
    } forEach _list;
    _sel
};

private _weightsGeneric = [
    ["Bloodsucker",1],["Boar",1],["Cat",1],["Flesh",1],["Blind Dog",1],
    ["Pseudodog",1],["Snork",1],["Controller",1],["Pseudogiant",1],["Izlom",1],
    ["Corruptor",1],["Smasher",1],["Acid Smasher",1],["Behemoth",1],
    ["Parasite",1],["Jumper",1],["Spitter",1],["Stalker",1],["Bully",1],["Hivemind",1],["Zombie",1]
];
private _weightsUrban = [
    ["Snork",3],["Blind Dog",3],["Controller",2],["Izlom",2],
    ["Pseudodog",1],["Boar",1],["Bloodsucker",1],["Flesh",1],["Pseudogiant",1],
    ["Cat",1],["Corruptor",1],["Smasher",1],["Acid Smasher",1],["Behemoth",1],
    ["Parasite",1],["Jumper",1],["Spitter",1],["Stalker",1],["Bully",1],["Hivemind",1],["Zombie",2]
];
private _weightsRural = [
    ["Boar",3],["Pseudodog",3],["Pseudogiant",2],
    ["Blind Dog",1],["Bloodsucker",1],["Flesh",1],["Cat",1],["Snork",1],
    ["Controller",1],["Izlom",1],["Corruptor",1],["Smasher",1],["Acid Smasher",1],["Behemoth",1],
    ["Parasite",1],["Jumper",1],["Spitter",1],["Stalker",1],["Bully",1],["Hivemind",1],["Zombie",1]
];
private _weightsForest = [
    ["Cat",3],["Pseudodog",2],["Boar",1],["Bloodsucker",1],["Flesh",1],
    ["Snork",1],["Controller",1],["Blind Dog",1],["Izlom",1],["Pseudogiant",1],
    ["Corruptor",1],["Smasher",1],["Acid Smasher",1],["Behemoth",1],
    ["Parasite",1],["Jumper",1],["Spitter",1],["Stalker",1],["Bully",1],["Hivemind",1],["Zombie",1]
];
private _weightsSwamp = [
    ["Bloodsucker",3],["Flesh",3],["Acid Smasher",2],
    ["Boar",1],["Pseudodog",1],["Pseudogiant",1],["Cat",1],["Snork",1],
    ["Controller",1],["Blind Dog",1],["Izlom",1],["Corruptor",1],["Smasher",1],["Behemoth",1],
    ["Parasite",1],["Jumper",1],["Spitter",1],["Stalker",3],["Bully",1],["Hivemind",1],["Zombie",1]
];

private _selectType = {
    params ["_env"];
    private _list = switch (_env) do {
        case "urban": { _weightsUrban };
        case "rural": { _weightsRural };
        case "forest": { _weightsForest };
        case "swamp": { _weightsSwamp };
        default { _weightsGeneric };
    };
    [_list] call _weightedPick
};

private _center = [worldSize/2, worldSize/2, 0];
private _locations = nearestLocations [_center, [], worldSize];
private _buildings = nearestObjects [_center, ["House"], worldSize];
_buildings append (allMissionObjects "building");
_buildings = _buildings arrayIntersect _buildings; // remove duplicates

{
    private _pos = locationPosition _x;
    _pos = [_pos, 0, 100, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (random 1 > 0.5) then {
        private _env = switch (type _x) do {
            case "NameCity": { "urban" };
            case "NameCityCapital": { "urban" };
            case "NameVillage": { "rural" };
            case "NameLocal": { "rural" };
            case "Hill": { "rural" };
            default { "generic" };
        };
        if (!(_pos call VIC_fnc_isWaterPosition)) then {
            private _type = [_env] call _selectType;
            [_type, _pos] call _createMarker;
        };
    };
} forEach _locations;

for "_i" from 1 to 20 do {
    if (_buildings isEqualTo []) exitWith {};
    private _b = selectRandom _buildings;
    private _pos = getPosATL _b;
    _pos = [_pos, 0, 25, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (!(_pos call VIC_fnc_isWaterPosition)) then {
        private _type = ["urban"] call _selectType;
        [_type, _pos] call _createMarker;
    };
};

private _forestSites = selectBestPlaces [_center, worldSize, "forest", 1, 50];
{
    private _pos = (_x select 0);
    _pos = [_pos, 0, 75, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (!(_pos call VIC_fnc_isWaterPosition)) then {
        private _type = ["forest"] call _selectType;
        [_type, _pos] call _createMarker;
    };
} forEach (_forestSites select [0,10]);

private _swampSites = selectBestPlaces [_center, worldSize, "meadow", 1, 50];
{
    private _pos = (_x select 0);
    _pos = [_pos, 0, 75, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (!(_pos call VIC_fnc_isWaterPosition)) then {
        private _type = ["swamp"] call _selectType;
        [_type, _pos] call _createMarker;
    };
} forEach (_swampSites select [0,10]);

private _allTypes = _weightsGeneric apply { _x#0 };
private _existing = STALKER_mutantHabitats apply { _x#5 };
{
    if (!(_x in _existing)) then {
        if !(_buildings isEqualTo []) then {
            private _p = getPosATL (selectRandom _buildings);
            _p = [_p, 0, 25, 5, 0, 0, 0] call BIS_fnc_findSafePos;
            if (!(_p call VIC_fnc_isWaterPosition)) then { [_x, _p] call _createMarker; };
        };
    };
} forEach _allTypes;

// Persist generated habitats for future sessions
["STALKER_mutantHabitatData", STALKER_mutantHabitatData] call VIC_fnc_saveCache;

true
