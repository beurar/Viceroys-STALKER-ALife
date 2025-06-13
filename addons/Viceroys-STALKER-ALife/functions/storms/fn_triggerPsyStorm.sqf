/*
    Author: Codex
    Description:
        Triggers lightning strikes and Psy Discharges across the map.
        Lightning and discharges have separate intensity curves.

    Params:
        0: NUMBER - duration of the storm in seconds (default 180)
        1: NUMBER - lightning strikes per second at storm start (default 6)
        2: NUMBER - lightning strikes per second when storm ends (default 12)
        3: NUMBER - discharge occurrences per second at storm start (default 6)
        4: NUMBER - discharge occurrences per second when storm ends (default 12)
*/

params [
    ["_duration", 180],
    ["_lightningStart", 6],
    ["_lightningEnd", 12],
    ["_dischargeStart", 6],
    ["_dischargeEnd", 12]
];


["triggerPsyStorm"] call VIC_fnc_debugLog;
private _range = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;

if (count allPlayers == 0) exitWith {};

private _ticks = floor _duration;
for "_i" from 1 to _ticks do {
    private _progress = (_i - 1) / (_ticks max 1);
    private _currentLightning = round (_lightningStart + (_lightningEnd - _lightningStart) * _progress);
    private _currentDischarge = round (_dischargeStart + (_dischargeEnd - _dischargeStart) * _progress);

    for "_j" from 1 to _currentLightning do {
        private _center = getPos (selectRandom allPlayers);
        private _pos = [
            (_center select 0) + (random (_range * 2) - _range),
            (_center select 1) + (random (_range * 2) - _range),
            0
        ];
        private _surf = [_pos] call VIC_fnc_getSurfacePosition;
        private _logic = "Logic" createVehicleLocal _surf;
        [_logic, [], true] call BIS_fnc_moduleLightning;
        deleteVehicle _logic;
    };

    for "_j" from 1 to _currentDischarge do {
        private _center = getPos (selectRandom allPlayers);
        private _pos = [
            (_center select 0) + (random (_range * 2) - _range),
            (_center select 1) + (random (_range * 2) - _range),
            0
        ];
        private _surf = [_pos] call VIC_fnc_getSurfacePosition;
        private _module = "diwako_anomalies_main_modulePsyDischarge" createVehicleLocal _surf;
        private _fncDischarge = missionNamespace getVariable ["diwako_anomalies_main_fnc_modulePsyDischarge", {}];
        ["init", _module] call _fncDischarge;
    };

    sleep 1;
};

