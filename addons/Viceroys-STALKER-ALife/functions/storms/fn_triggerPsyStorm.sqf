/*
    Author: Codex
    Description:
        Triggers lightning strikes and Psy Discharges across the map.

    Params:
        0: NUMBER - duration of the storm in seconds (default 180)
        1: NUMBER - starting strikes per second (default 2)
        2: NUMBER - ending strikes per second (default 6)
*/

params [
    ["_duration", 180],
    ["_startIntensity", 2],
    ["_endIntensity", 6]
];

["triggerPsyStorm"] call VIC_fnc_debugLog;

private _ticks = floor _duration;
for "_i" from 1 to _ticks do {
    private _progress = (_i - 1) / (_ticks max 1);
    private _currentIntensity = round (_startIntensity + (_endIntensity - _startIntensity) * _progress);

    for "_j" from 1 to _currentIntensity do {
        private _pos = [random worldSize, random worldSize, 0];
        private _surf = [_pos] call VIC_fnc_getSurfacePosition;
        private _module = "diwako_anomalies_main_modulePsyDischarge" createVehicle _surf;
        private _fncDischarge = missionNamespace getVariable ["diwako_anomalies_main_fnc_modulePsyDischarge", {}];
        ["init", _module] call _fncDischarge;
        private _logic = "Logic" createVehicle _surf;
        [_logic, [], true] call BIS_fnc_moduleLightning;
        deleteVehicle _logic;
    };

    sleep 1;
};

