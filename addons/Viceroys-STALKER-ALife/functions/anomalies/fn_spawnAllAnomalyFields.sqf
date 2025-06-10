/*
    Spawns anomaly fields around a position.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER            - search radius
*/
params ["_center","_radius"];

["spawnAllAnomalyFields"] call VIC_fnc_debugLog;

if (["VSA_enableAnomalies", true] call CBA_fnc_getSetting isEqualTo false) exitWith {};

private _fieldCount = ["VSA_anomalyFieldCount", 3] call CBA_fnc_getSetting;
private _spawnWeight = ["VSA_anomalySpawnWeight", 50] call CBA_fnc_getSetting;
private _nightOnly   = ["VSA_anomalyNightOnly", false] call CBA_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

if (![_center, 1500] call VIC_fnc_hasPlayersNearby) exitWith {};

private _types = [
    VIC_fnc_createField_burner,
    VIC_fnc_createField_clicker,
    VIC_fnc_createField_electra,
    VIC_fnc_createField_fruitpunch,
    VIC_fnc_createField_gravi,
    VIC_fnc_createField_meatgrinder,
    VIC_fnc_createField_springboard,
    VIC_fnc_createField_whirligig
];

for "_i" from 1 to _fieldCount do {
    if (random 100 >= _spawnWeight) then { continue };
    private _fn = selectRandom _types;
    [_center, _radius] call _fn;
};
