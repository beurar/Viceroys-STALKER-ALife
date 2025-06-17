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

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {
    ["spawnAllAnomalyFields: night only"] call VIC_fnc_debugLog;
};

if (isNil "STALKER_anomalyFields") then { STALKER_anomalyFields = [] };

private _types = [
    VIC_fnc_createField_burner,
    VIC_fnc_createField_clicker,
    VIC_fnc_createField_electra,
    VIC_fnc_createField_fruitpunch,
    VIC_fnc_createField_gravi,
    VIC_fnc_createField_meatgrinder,
    VIC_fnc_createField_springboard,
    VIC_fnc_createField_whirligig,
    VIC_fnc_createField_comet,
    VIC_fnc_createField_launchpad,
    VIC_fnc_createField_leech,
    VIC_fnc_createField_trapdoor,
    VIC_fnc_createField_zapper,
    VIC_fnc_createField_bridgeElectra
];

for "_i" from 1 to _fieldCount do {
    if ((count STALKER_anomalyMarkers) >= _maxFields) exitWith {
        ["spawnAllAnomalyFields: max fields reached"] call VIC_fnc_debugLog;
    };

    if (random 100 >= _spawnWeight) then { continue };

    private _pos = [[random worldSize, random worldSize, 0], 50, 10, false, worldSize] call VIC_fnc_findLandPosition;
    if (_pos isEqualTo []) then { continue };

    private _fn = selectRandom _types;
    private _typeName = switch (_fn) do {
        case VIC_fnc_createField_burner: {"burner"};
        case VIC_fnc_createField_electra: {"electra"};
        case VIC_fnc_createField_fruitpunch: {"fruitpunch"};
        case VIC_fnc_createField_springboard: {"springboard"};
        case VIC_fnc_createField_gravi: {"gravi"};
        case VIC_fnc_createField_meatgrinder: {"meatgrinder"};
        case VIC_fnc_createField_whirligig: {"whirligig"};
        case VIC_fnc_createField_comet: {"comet"};
        case VIC_fnc_createField_clicker: {"clicker"};
        case VIC_fnc_createField_launchpad: {"launchpad"};
        case VIC_fnc_createField_leech: {"leech"};
        case VIC_fnc_createField_trapdoor: {"trapdoor"};
        case VIC_fnc_createField_zapper: {"zapper"};
        case VIC_fnc_createField_bridgeElectra: {"bridge"};
        default {""};
    };

    [format ["spawnAllAnomalyFields: attempting %1", _typeName]] call VIC_fnc_debugLog;
    private _stable = if (_type == -1) then { (random 100) < _stableChance } else { _type == 1 };

    private _spawned = [_pos, 75] call _fn;
    if (_spawned isEqualTo []) then {
        [format ["spawnAllAnomalyFields: %1 failed", _typeName]] call VIC_fnc_debugLog;
        continue;
    };

    private _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
    private _site   = if (_marker isEqualTo "") then { getPosATL (_spawned select 0) } else { getMarkerPos _marker };
    if (_marker != "") then {
        _marker setMarkerAlpha 0.2;
        if (_stable) then {
            _marker setMarkerText ([_typeName, _site] call VIC_fnc_generateFieldName);
        };
    };

    private _dur = missionNamespace getVariable ["STALKER_AnomalyFieldDuration", 30];
    private _exp = diag_tickTime + (_dur * 60);
    STALKER_anomalyFields pushBack [_pos,75,_fn,count _spawned,_spawned,_marker,_site,_exp,_stable];
    [format ["spawnAllAnomalyFields: spawned %1 %2", count _spawned, _typeName]] call VIC_fnc_debugLog;
};

true
