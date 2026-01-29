/*
    Spawns a number of anomaly fields at random locations across the map.
    Fields persist for `STALKER_AnomalyFieldDuration` minutes before being
    removed automatically.

    Params:
        0: POSITION or OBJECT - (ignored) kept for backward compatibility
        1: NUMBER             - (ignored) kept for backward compatibility
        2: NUMBER             - forces stable (1) or unstable (0) fields
*/
params ["_center","_radius", ["_type", -1]];

// variables kept for compatibility
_center;
_radius;


["spawnAllAnomalyFields"] call VIC_fnc_debugLog;

if (["VSA_enableAnomalies", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["spawnAllAnomalyFields: anomalies disabled"] call VIC_fnc_debugLog;
};

// Prepare anomaly marker tracking
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = [] };
private _maxFields = ["VSA_maxAnomalyFields", 20] call VIC_fnc_getSetting;

private _fieldCount = ["VSA_anomalyFieldCount", 3] call VIC_fnc_getSetting;
private _spawnWeight = ["VSA_anomalySpawnWeight", 50] call VIC_fnc_getSetting;
private _stableChance  = ["VSA_stableFieldChance", 50] call VIC_fnc_getSetting;
private _nightOnly   = ["VSA_anomalyNightOnly", false] call VIC_fnc_getSetting;

if (_nightOnly && {dayTime > 5 && dayTime < 20}) exitWith {
    ["spawnAllAnomalyFields: night only"] call VIC_fnc_debugLog;
};

if (isNil "STALKER_anomalyFields") then { STALKER_anomalyFields = [] };

private _weights = [
    [VIC_fnc_createField_burner,      ["VSA_anomalyWeight_Burner",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_clicker,     ["VSA_anomalyWeight_Clicker",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_electra,     ["VSA_anomalyWeight_Electra",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_fruitpunch,  ["VSA_anomalyWeight_Fruitpunch",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_gravi,       ["VSA_anomalyWeight_Gravi",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_meatgrinder, ["VSA_anomalyWeight_Meatgrinder",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_springboard, ["VSA_anomalyWeight_Springboard",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_whirligig,   ["VSA_anomalyWeight_Whirligig",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_launchpad,   ["VSA_anomalyWeight_Launchpad",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_leech,       ["VSA_anomalyWeight_Leech",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_trapdoor,    ["VSA_anomalyWeight_Trapdoor",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_zapper,      ["VSA_anomalyWeight_Zapper",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_razor,       ["VSA_anomalyWeight_Razor",100] call VIC_fnc_getSetting],
    [VIC_fnc_createField_bridgeAnomaly,["VSA_anomalyWeight_Bridge",100] call VIC_fnc_getSetting]
];

for "_i" from 1 to _fieldCount do {
    if ((count STALKER_anomalyMarkers) >= _maxFields) exitWith {
        ["spawnAllAnomalyFields: max fields reached"] call VIC_fnc_debugLog;
    };

    if (random 100 >= _spawnWeight) then { continue };

    private _pos = [[random worldSize, random worldSize, 0], worldSize, 10] call VIC_fnc_findLandPos;
    if (isNil {_pos} || {_pos isEqualTo []}) then { continue };

    private _fn = [_weights] call VIC_fnc_weightedPick;
    private _typeName = switch (_fn) do {
        case VIC_fnc_createField_burner: {"burner"};
        case VIC_fnc_createField_electra: {"electra"};
        case VIC_fnc_createField_fruitpunch: {"fruitpunch"};
        case VIC_fnc_createField_springboard: {"springboard"};
        case VIC_fnc_createField_gravi: {"gravi"};
        case VIC_fnc_createField_meatgrinder: {"meatgrinder"};
        case VIC_fnc_createField_whirligig: {"whirligig"};
        case VIC_fnc_createField_clicker: {"clicker"};
        case VIC_fnc_createField_launchpad: {"launchpad"};
        case VIC_fnc_createField_leech: {"leech"};
        case VIC_fnc_createField_trapdoor: {"trapdoor"};
        case VIC_fnc_createField_zapper: {"zapper"};
        case VIC_fnc_createField_razor: {"razor"};
        case VIC_fnc_createField_bridgeAnomaly: {"bridge"};
        default {""};
    };

    [format ["spawnAllAnomalyFields: attempting %1", _typeName]] call VIC_fnc_debugLog;
    private _stable = if (_type == -1) then { (random 100) < _stableChance } else { _type == 1 };

    private _spawned = [_pos, 75] call _fn;
    if (_spawned isEqualTo []) then {
        [format ["spawnAllAnomalyFields: %1 failed", _typeName]] call VIC_fnc_debugLog;
        continue;
    };

    private _anchor = [_pos] call VIC_fnc_createProximityAnchor;

    private _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
    private _site   = if (_marker isEqualTo "") then { getPosATL (_spawned select 0) } else { getMarkerPos _marker };
    if (_marker != "") then {
        _marker setMarkerBrushLocal "Border";
        _marker setMarkerAlpha 1;
        if (_stable) then {
            _marker setMarkerText ([_typeName, _site] call VIC_fnc_generateFieldName);
        };
    };

    private _dur = missionNamespace getVariable ["STALKER_AnomalyFieldDuration", 30];
    private _exp = diag_tickTime + (_dur * 60);
    STALKER_anomalyFields pushBack [_pos,_anchor,75,_fn,count _spawned,_spawned,_marker,_site,_exp,_stable,false];
    [format ["spawnAllAnomalyFields: spawned %1 %2", count _spawned, _typeName]] call VIC_fnc_debugLog;
}; 

// Bridges are now spawned via separate helper
[_type] call VIC_fnc_spawnBridgeAnomalyFields;

true
