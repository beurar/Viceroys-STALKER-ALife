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

if (![_center, 1500] call VIC_fnc_hasPlayersNearby) exitWith {};

private _types = [
    VIC_fnc_createField_burner,
    VIC_fnc_createField_clicker,
    VIC_fnc_createField_electra,
    VIC_fnc_createField_fruitpunch,
    VIC_fnc_createField_gravi,
    VIC_fnc_createField_meatgrinder,
    VIC_fnc_createField_springboard,
    VIC_fnc_createField_whirligig,
    VIC_fnc_createField_launchpad,
    VIC_fnc_createField_leech,
    VIC_fnc_createField_trapdoor,
    VIC_fnc_createField_zapper
];

private _duration = missionNamespace getVariable ["STALKER_AnomalyFieldDuration", 30];

for "_i" from 1 to _fieldCount do {
    if ((count STALKER_anomalyMarkers) >= _maxFields) exitWith {};
    if (random 100 >= _spawnWeight) then { continue };
    private _fn = selectRandom _types;
    private _spawned = [_center, _radius] call _fn;

    if (_spawned isEqualTo []) then { continue };
    private _marker = (_spawned select 0) getVariable ["zoneMarker", ""];

    [_spawned, _marker, _duration] spawn {
        params ["_objects", "_marker", "_dur"];
        sleep (_dur * 60);
        {
            if (!isNull _x) then { deleteVehicle _x; };
        } forEach _objects;
        if (_marker isNotEqualTo "") then {
            deleteMarker _marker;
            if (!isNil "STALKER_anomalyMarkers") then {
                private _idx = STALKER_anomalyMarkers find _marker;
                if (_idx >= 0) then { STALKER_anomalyMarkers deleteAt _idx; };
            };
        };
    };
};
