/*
    Spawns anomaly fields around a position.
    Params:
        0: POSITION or OBJECT - search center
        1: NUMBER            - search radius
*/
params ["_center","_radius"];

if (["VSA_enableAnomalies", true] call CBA_fnc_getSetting isEqualTo false) exitWith {};

private _fieldCount = ["VSA_anomalyFieldCount", 3] call CBA_fnc_getSetting;
private _spawnWeight = ["VSA_anomalySpawnWeight", 50] call CBA_fnc_getSetting;
private _nightOnly   = ["VSA_anomalyNightOnly", false] call CBA_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

private _types = [
    VSTKR_fnc_createField_burner,
    VSTKR_fnc_createField_clicker,
    VSTKR_fnc_createField_electra,
    VSTKR_fnc_createField_fruitpunch,
    VSTKR_fnc_createField_gravi,
    VSTKR_fnc_createField_meatgrinder,
    VSTKR_fnc_createField_springboard,
    VSTKR_fnc_createField_whirligig
];

for "_i" from 1 to _fieldCount do {
    if (random 100 >= _spawnWeight) then { continue };
    private _fn = selectRandom _types;
    [_center, _radius] call _fn;
};
