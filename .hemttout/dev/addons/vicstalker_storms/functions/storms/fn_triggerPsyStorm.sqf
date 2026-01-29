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
        5: NUMBER - fog level when the storm peaks (default 0.6)
        6: NUMBER - rain intensity when the storm peaks (default 0.8)
        7: NUMBER - overcast level during the storm (default 1)
        8: NUMBER - seconds to reach full overcast before strikes (default 60)
*/

params [
    ["_duration", 180],
    ["_lightningStart", 6],
    ["_lightningEnd", 12],
    ["_dischargeStart", 6],
    ["_dischargeEnd", 12],
    ["_fogEnd", 0.6],
    ["_rainEnd", 0.8],
    ["_overcastEnd", 1],
    ["_overcastTime", 60]
];


["triggerPsyStorm"] call VIC_fnc_debugLog;
private _startFog = fog;
private _startRain = rain;
private _startOvercast = overcast;
private _range = ["VSA_stormRadius", 1500] call VIC_fnc_getSetting;
private _gasEnabled = ["VSA_stormGasDischarges", true] call VIC_fnc_getSetting;

private _stepsOvercast = floor _overcastTime;
if (_stepsOvercast > 0) then {
    for "_i" from 1 to _stepsOvercast do {
        private _prog = _i / (_stepsOvercast max 1);
        private _current = _startOvercast + (_overcastEnd - _startOvercast) * _prog;
        0 setOvercast _current;
        sleep 1;
    };
} else {
    0 setOvercast _overcastEnd;
};
forceWeatherChange;

if (allPlayers isEqualTo []) exitWith {};

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
        private _pos = [_center, random _range, random 360] call BIS_fnc_relPos;
        private _surf = [_pos] call VIC_fnc_getSurfacePosition;
        // createAgent is required for Logic objects as they have a brain
        private _logic = createAgent ["Logic", _surf, [], 0, "CAN_COLLIDE"];
        [_logic, [], true] call BIS_fnc_moduleLightning;
        deleteVehicle _logic;
    };

    for "_j" from 1 to _currentDischarge do {
        private _center = getPos (selectRandom allPlayers);
        private _pos = [_center, random _range, random 360] call BIS_fnc_relPos;
        private _surf = [_pos] call VIC_fnc_getSurfacePosition;
        private _fncDischarge = missionNamespace getVariable ["diwako_anomalies_main_fnc_createPsyDischarge", {}];
        if (_fncDischarge isEqualTo {}) then {
            ["triggerPsyStorm: Diwako Anomalies missing"] call VIC_fnc_debugLog;
        } else {
            [_surf] remoteExec ["diwako_anomalies_main_fnc_createPsyDischarge", 0];
        };
        if (_gasEnabled) then {
            // Spawn a Nova mist after the discharge finishes using CBA settings
            private _radius  = ["VSA_stormGasRadius", 20] call VIC_fnc_getSetting;
            private _density = ["VSA_stormGasDensity", 3] call VIC_fnc_getSetting;
            private _vertical = ["VSA_stormGasVertical", 1] call VIC_fnc_getSetting;

            // Convert the surface position from ASL to AGL so the gas spawns on the ground
            private _agl = ASLToAGL _surf;
            if (isNil "CBRN_fnc_spawnMist") then {
                ["triggerPsyStorm: CBRN mod missing"] call VIC_fnc_debugLog;
            } else {
                [_agl, _radius, 20, 4, _vertical, _density] spawn {
                    params ["_pos", "_r", "_dur", "_chem", "_vert", "_dens"];
                    sleep 5;
                    [_pos, _r, _dur, _chem, _vert, _dens] remoteExec ["CBRN_fnc_spawnMist", 0];
                };
            };
        };
    };

    sleep 1;
};

0 setFog _startFog;
0 setRain _startRain;
if (_stepsOvercast > 0) then {
    for "_i" from 1 to _stepsOvercast do {
        private _prog = _i / (_stepsOvercast max 1);
        private _current = _overcastEnd + (_startOvercast - _overcastEnd) * _prog;
        0 setOvercast _current;
        sleep 1;
    };
};
0 setOvercast _startOvercast;
forceWeatherChange;

