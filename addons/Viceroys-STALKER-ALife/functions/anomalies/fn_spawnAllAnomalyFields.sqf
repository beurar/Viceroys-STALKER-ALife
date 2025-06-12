/*
    Spawns anomaly fields around a position.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER            - search radius
*/
params ["_center","_radius"];

["spawnAllAnomalyFields"] call VIC_fnc_debugLog;

if (["VSA_enableAnomalies", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

// Prepare anomaly marker tracking
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _maxFields = ["VSA_maxAnomalyFields", 20] call VIC_fnc_getSetting;

private _fieldCount = ["VSA_anomalyFieldCount", 3] call VIC_fnc_getSetting;
private _spawnWeight = ["VSA_anomalySpawnWeight", 50] call VIC_fnc_getSetting;
private _nightOnly   = ["VSA_anomalyNightOnly", false] call VIC_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

if (isNil "STALKER_anomalyFields") then { STALKER_anomalyFields = [] };

private _types = [
    [VIC_fnc_createField_burner,      VIC_fnc_findSite_burner],
    [VIC_fnc_createField_clicker,     VIC_fnc_findSite_clicker],
    [VIC_fnc_createField_electra,     VIC_fnc_findSite_electra],
    [VIC_fnc_createField_fruitpunch,  VIC_fnc_findSite_fruitpunch],
    [VIC_fnc_createField_gravi,       VIC_fnc_findSite_gravi],
    [VIC_fnc_createField_meatgrinder, VIC_fnc_findSite_meatgrinder],
    [VIC_fnc_createField_springboard, VIC_fnc_findSite_springboard],
    [VIC_fnc_createField_whirligig,   VIC_fnc_findSite_whirligig],
    [VIC_fnc_createField_launchpad,   VIC_fnc_findSite_launchpad],
    [VIC_fnc_createField_leech,       VIC_fnc_findSite_leech],
    [VIC_fnc_createField_trapdoor,    VIC_fnc_findSite_trapdoor],
    [VIC_fnc_createField_zapper,      VIC_fnc_findSite_zapper]
];

for "_i" from 1 to _fieldCount do {
    if ((count STALKER_anomalyMarkers) >= _maxFields) exitWith {};
    if (random 100 >= _spawnWeight) then { continue };
    private _pair  = selectRandom _types;
    private _fn    = _pair select 0;
    private _finder = _pair select 1;
    private _site  = [_center, _radius] call _finder;
    if (_site isEqualTo []) then { continue };
    _site = [_site] call VIC_fnc_findLandPosition;
    if (_site isEqualTo []) then { continue };
    private _spawned = [_center, _radius, 1, _site] call _fn;
    if (_spawned isEqualTo []) then { continue };
    private _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
    { if (!isNull _x) then { deleteVehicle _x; } } forEach _spawned;
    if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    STALKER_anomalyFields pushBack [_center,_radius,_fn,5,[],_marker,_site];
};
