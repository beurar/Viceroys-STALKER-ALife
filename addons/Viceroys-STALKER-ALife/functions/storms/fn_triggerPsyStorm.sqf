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
    ["_dischargeEnd", 12],
    ["_fogEnd", 0.6],
    ["_rainEnd", 0.8]
];


["triggerPsyStorm"] call VIC_fnc_debugLog;
private _startFog = fog;
private _startRain = rain;
private _range = ["VSA_stormRadius", 1500] call VIC_fnc_getSetting;
private _gasEnabled = ["VSA_stormGasDischarges", false] call VIC_fnc_getSetting;

if (count allPlayers == 0) exitWith {};

private _ticks = floor _duration;
for "_i" from 1 to _ticks do {
    private _progress = (_i - 1) / (_ticks max 1);
    private _currentLightning = round (_lightningStart + (_lightningEnd - _lightningStart) * _progress);
    private _currentDischarge = round (_dischargeStart + (_dischargeEnd - _dischargeStart) * _progress);
    private _currentFog = _startFog + (_fogEnd - _startFog) * _progress;
    private _currentRain = _startRain + (_rainEnd - _startRain) * _progress;
    0 setFog _currentFog;
    0 setRain _currentRain;

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
        if (_gasEnabled) then {
            // Spawn a 30m Nova Gas cloud lasting 90 seconds
            [_surf, 30, 90, 4] call VIC_fnc_spawnChemicalZone;
        };
    };

    sleep 1;
};

0 setFog _startFog;
0 setRain _startRain;

