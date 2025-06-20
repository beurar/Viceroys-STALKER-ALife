/*
    Generates anomaly fields across the map using the same logic as mutant habitats.
    This runs on the server during initialization.
*/

["setupAnomalyFields"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (isNil "STALKER_anomalyFields") then { STALKER_anomalyFields = []; };
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = []; };

private _createField = {
    params ["_fn", "_pos"];

    // Skip this location if it overlaps an existing field
    private _overlap = false;
    {
        if (_pos distance2D (_x#6) < 300) exitWith { _overlap = true };
    } forEach STALKER_anomalyFields;
    if (_overlap) exitWith { false };

    private _spawned = [_pos, 75] call _fn;
    if (_spawned isEqualTo []) exitWith { false };

    private _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
    if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    private _dur = missionNamespace getVariable ["STALKER_AnomalyFieldDuration", 30];
    private _exp = diag_tickTime + (_dur * 60);

    STALKER_anomalyFields pushBack [_pos,75,_fn,count _spawned,_spawned,_marker,_pos,_exp,true];
    true
};

private _weights = [
    [VIC_fnc_createField_burner,      ["VSA_anomalyWeight_Burner",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_clicker,     ["VSA_anomalyWeight_Clicker",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_electra,     ["VSA_anomalyWeight_Electra",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_fruitpunch,  ["VSA_anomalyWeight_Fruitpunch",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_gravi,       ["VSA_anomalyWeight_Gravi",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_meatgrinder, ["VSA_anomalyWeight_Meatgrinder",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_springboard, ["VSA_anomalyWeight_Springboard",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_whirligig,   ["VSA_anomalyWeight_Whirligig",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_comet,       ["VSA_anomalyWeight_Comet",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_launchpad,   ["VSA_anomalyWeight_Launchpad",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_leech,       ["VSA_anomalyWeight_Leech",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_trapdoor,    ["VSA_anomalyWeight_Trapdoor",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_zapper,      ["VSA_anomalyWeight_Zapper",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_bridgeElectra,["VSA_anomalyWeight_Bridge",100] call VIC_fnc_getSetting]
];

private _center = [worldSize/2, worldSize/2, 0];
private _locations = nearestLocations [_center, [], worldSize];
private _buildings = nearestObjects [_center, ["House"], worldSize];
_buildings append (allMissionObjects "building");
_buildings = _buildings arrayIntersect _buildings; // remove duplicates

{
    private _pos = locationPosition _x;
    _pos = [_pos, 0, 100, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (random 1 > 0.5) then {
        if (!(_pos call VIC_fnc_isWaterPosition)) then {
            private _fn = [_weights] call VIC_fnc_weightedPick;
            [_fn, _pos] call _createField;
        };
    };
} forEach _locations;

for "_i" from 1 to 20 do {
    if (_buildings isEqualTo []) exitWith {};
    private _b = selectRandom _buildings;
    private _pos = getPosATL _b;
    _pos = [_pos, 0, 25, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (!(_pos call VIC_fnc_isWaterPosition)) then {
        private _fn = [_weights] call VIC_fnc_weightedPick;
        [_fn, _pos] call _createField;
    };
};

private _forestSites = selectBestPlaces [_center, worldSize, "forest", 1, 50];
{
    private _pos = (_x select 0);
    _pos = [_pos, 0, 75, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (!(_pos call VIC_fnc_isWaterPosition)) then {
        private _fn = [_weights] call VIC_fnc_weightedPick;
        [_fn, _pos] call _createField;
    };
} forEach (_forestSites select [0,10]);

private _swampSites = selectBestPlaces [_center, worldSize, "meadow", 1, 50];
{
    private _pos = (_x select 0);
    _pos = [_pos, 0, 75, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (!(_pos call VIC_fnc_isWaterPosition)) then {
        private _fn = [_weights] call VIC_fnc_weightedPick;
        [_fn, _pos] call _createField;
    };
} forEach (_swampSites select [0,10]);

true
