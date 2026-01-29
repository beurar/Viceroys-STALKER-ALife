/*
    Creates a random anomaly field positioned on a bridge.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER - search radius
        2: NUMBER - anomaly count (optional, -1 = random)
        3: ARRAY (optional) - site position to use (must be valid when provided)
    Returns: ARRAY - spawned anomalies
*/
params ["_center","_radius", ["_count",-1], ["_site", []]];
["fn_createField_bridgeAnomaly"] call VIC_fnc_debugLog;

if (isNil {_site} || {count _site == 0}) then {
    _site = [_center,_radius] call VIC_fnc_findSite_bridge;
    if (count _site == 0) exitWith {
        ["createField_bridgeAnomaly: no site"] call VIC_fnc_debugLog;
        []
    };
} else {
    [format ["createField_bridgeAnomaly: using site %1", _site]] call VIC_fnc_debugLog;
};
_site = [_site] call VIC_fnc_findLandPos;
if (isNil {_site} || {count _site == 0}) exitWith {
    ["createField_bridgeAnomaly: land position failed"] call VIC_fnc_debugLog;
    []
};

if (_count < 0) then {
    private _max = ["VSA_anomaliesPerField", 40] call VIC_fnc_getSetting;
    _max = _max max 5;
    _count = floor (random (_max - 5 + 1)) + 5;
    private _dens = ["VSA_anomalyDensity_Bridge",100] call VIC_fnc_getSetting;
    _count = round (_count * (_dens / 100));
};

private _size = ["VSA_bridgeFieldRadius", 200] call VIC_fnc_getSetting;

if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _markerName = format ["anom_bridge_%1", diag_tickTime];
private _marker = [_markerName, _site, "ELLIPSE", "", VIC_colorBridgeCyan, 1, format ["Bridge Anomaly %1m", _size]] call VIC_fnc_createGlobalMarker;
_marker setMarkerSizeLocal [_size,_size];
_marker setMarkerBrush "Border";
STALKER_anomalyMarkers pushBack _marker;

private _weights = [
    ["burner",      ["VSA_anomalyWeight_Burner",100] call VIC_fnc_getSetting],
    ["clicker",     ["VSA_anomalyWeight_Clicker",100] call VIC_fnc_getSetting],
    ["electra",     ["VSA_anomalyWeight_Electra",100] call VIC_fnc_getSetting],
    ["fruitpunch",  ["VSA_anomalyWeight_Fruitpunch",100] call VIC_fnc_getSetting],
    ["gravi",       ["VSA_anomalyWeight_Gravi",100] call VIC_fnc_getSetting],
    ["meatgrinder", ["VSA_anomalyWeight_Meatgrinder",100] call VIC_fnc_getSetting],
    ["springboard", ["VSA_anomalyWeight_Springboard",100] call VIC_fnc_getSetting],
    ["whirligig",   ["VSA_anomalyWeight_Whirligig",100] call VIC_fnc_getSetting],
    ["launchpad",   ["VSA_anomalyWeight_Launchpad",100] call VIC_fnc_getSetting],
    ["leech",       ["VSA_anomalyWeight_Leech",100] call VIC_fnc_getSetting],
    ["trapdoor",    ["VSA_anomalyWeight_Trapdoor",100] call VIC_fnc_getSetting],
    ["zapper",      ["VSA_anomalyWeight_Zapper",100] call VIC_fnc_getSetting],
    ["razor",       ["VSA_anomalyWeight_Razor",100] call VIC_fnc_getSetting]
];

private _spawned = [];
for "_i" from 1 to _count do {
    private _off = [_site, random _size, random 360] call BIS_fnc_relPos;
    private _surf = [_off] call VIC_fnc_getLandSurfacePosition;
    if (_surf isEqualTo []) then { continue };
    private _type = [_weights] call VIC_fnc_weightedPick;
    private _anom = objNull;
    switch (_type) do {
        case "burner": {
            private _fn = missionNamespace getVariable ["diwako_anomalies_main_fnc_createBurner", {}];
            if (_fn isNotEqualTo {}) then { _anom = [_surf] call _fn; };
        };
        case "clicker": {
            private _fn = missionNamespace getVariable ["diwako_anomalies_main_fnc_createClicker", {}];
            if (_fn isNotEqualTo {}) then { _anom = [_surf] call _fn; };
        };
        case "electra": {
            private _fn = missionNamespace getVariable ["diwako_anomalies_main_fnc_createElectra", {}];
            if (_fn isNotEqualTo {}) then { _anom = [_surf] call _fn; };
        };
        case "fruitpunch": {
            private _fn = missionNamespace getVariable ["diwako_anomalies_main_fnc_createFruitPunch", {}];
            if (_fn isNotEqualTo {}) then { _anom = [_surf] call _fn; };
        };
        case "gravi": {
            private _fn = missionNamespace getVariable ["diwako_anomalies_main_fnc_createGravi", {}];
            if (_fn isNotEqualTo {}) then { _anom = [_surf] call _fn; };
        };
        case "meatgrinder": {
            private _fn = missionNamespace getVariable ["diwako_anomalies_main_fnc_createMeatgrinder", {}];
            if (_fn isNotEqualTo {}) then { _anom = [_surf] call _fn; };
        };
        case "springboard": {
            private _fn = missionNamespace getVariable ["diwako_anomalies_main_fnc_createSpringboard", {}];
            if (_fn isNotEqualTo {}) then { _anom = [_surf] call _fn; };
        };
        case "whirligig": {
            private _fn = missionNamespace getVariable ["diwako_anomalies_main_fnc_createWhirligig", {}];
            if (_fn isNotEqualTo {}) then { _anom = [_surf] call _fn; };
        };
        case "launchpad": { _anom = createVehicle ["DSA_Launchpad", ASLToATL _surf, [], 0, "NONE"] }; 
        case "leech":     { _anom = createVehicle ["DSA_Leech", ASLToATL _surf, [], 0, "NONE"] }; 
        case "trapdoor":  { _anom = createVehicle ["DSA_Trapdoor", ASLToATL _surf, [], 0, "NONE"] }; 
        case "zapper":    { _anom = createVehicle ["DSA_Zapper", ASLToATL _surf, [], 0, "NONE"] }; 
        case "razor":     { _anom = createVehicle ["DSA_Razor", ASLToATL _surf, [], 0, "NONE"] }; 
    };
    if (!isNull _anom) then {
        _anom setVariable ["zoneMarker", _marker];
        _spawned pushBack _anom;
    };
};
[format ["createField_bridgeAnomaly spawned %1", count _spawned]] call VIC_fnc_debugLog;
_spawned
