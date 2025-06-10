/*
    Author: STALKER ALife Script
    Description:
        Spawns a set of Drongo's spook zones using locations gathered by
        fn_setupSpookZones.sqf. The number of zones spawned is controlled by
        STALKER_MinSpookFields and STALKER_MaxSpookFields. Each zone persists
        for STALKER_SpookDuration minutes.
*/

if (isNil "drg_spook_zone_positions") then {
    [] call compile preprocessFileLineNumbers "functions/spooks/fn_setupSpookZones.sqf";
};

private _min = missionNamespace getVariable ["STALKER_MinSpookFields",1];
private _max = missionNamespace getVariable ["STALKER_MaxSpookFields",3];
private _duration = missionNamespace getVariable ["STALKER_SpookDuration",15];

private _count = round random [_min, _max, _max];
if (_count < _min) then { _count = _min; };

if (isNil "drg_activeSpookZones") then { drg_activeSpookZones = []; };

for "_i" from 1 to _count do {
    private _pos = selectRandom drg_spook_zone_positions;
    if (!isNil "_pos") then {
        private _zone = createTrigger ["EmptyDetector", _pos];
        _zone setTriggerArea [25,25,0,false];
        _zone setVariable ["isSpookZone", true];
        drg_activeSpookZones pushBack _zone;
        [_zone, _duration] spawn {
            params ["_zone","_dur"];
            sleep (_dur * 60);
            if (!isNull _zone) then {
                deleteVehicle _zone;
            };
        };
    };
};
