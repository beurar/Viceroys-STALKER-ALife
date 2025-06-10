/*
    Author: STALKER ALife Script
    Description:
        Spawns a set of Drongo's spook zones using locations gathered by
        fn_setupSpookZones.sqf. Zone counts and behaviour are configured via
        CBA settings:
          - VSA_enableSpooks
          - VSA_spookZoneCount
          - VSA_spookSpawnWeight
          - VSA_spooksNightOnly
          - STALKER_SpookDuration controls lifetime
*/

["spawnSpookZone"] call VIC_fnc_debugLog;

if (isNil "drg_spook_zone_positions") then {
    [] call compile preprocessFileLineNumbers "functions/spooks/fn_setupSpookZones.sqf";
};

if (["VSA_enableSpooks", true] call CBA_fnc_getSetting isEqualTo false) exitWith {};

private _count = ["VSA_spookZoneCount", 1] call CBA_fnc_getSetting;
private _weight = ["VSA_spookSpawnWeight", 50] call CBA_fnc_getSetting;
private _nightOnly = ["VSA_spooksNightOnly", true] call CBA_fnc_getSetting;
private _duration = missionNamespace getVariable ["STALKER_SpookDuration",15];

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

if (isNil "drg_activeSpookZones") then { drg_activeSpookZones = []; };

for "_i" from 1 to _count do {
    if (random 100 >= _weight) then { continue };
    private _pos = selectRandom drg_spook_zone_positions;
    if (!isNil "_pos") then {
        private _zone = createTrigger ["EmptyDetector", _pos];
        _zone setTriggerArea [25,25,0,false];
        _zone setVariable ["isSpookZone", true];

        // Create a map marker so the zone is visible for debugging or admin use
        private _markerName = format ["spook_%1", diag_tickTime];
        private _marker = createMarker [_markerName, _pos];
        _marker setMarkerShape "ELLIPSE";
        _marker setMarkerSize [25,25];
        _marker setMarkerColor "ColorBlack";
        _marker setMarkerText "Spook 25m";

        // Store the marker reference on the zone for later cleanup
        _zone setVariable ["zoneMarker", _marker];

        drg_activeSpookZones pushBack _zone;
        [_zone, _duration] spawn {
            params ["_zone","_dur"];
            sleep (_dur * 60);
            if (!isNull _zone) then {
                private _m = _zone getVariable ["zoneMarker", ""];
                if (_m isNotEqualTo "") then { deleteMarker _m; };
                deleteVehicle _zone;
            };
        };
    };
};
