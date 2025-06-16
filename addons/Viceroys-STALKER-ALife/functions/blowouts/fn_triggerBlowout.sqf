/*
    Trigger a single blowout using Diwako's Anomalies.
    Params:
        0: NUMBER - minimum duration in seconds (default 300)
        1: NUMBER - maximum duration in seconds (default 900)
        2: NUMBER - approach direction in degrees (default 0)
        3: NUMBER - minimum wave speed in m/s (default 125)
        4: NUMBER - maximum wave speed in m/s (default 125)
*/
params [
    ["_minDur",300],
    ["_maxDur",900],
    ["_dir",0],
    ["_speedMin",125],
    ["_speedMax",125]
];

_minDur   = ["VSA_blowoutDurationMin", _minDur] call VIC_fnc_getSetting;
_maxDur   = ["VSA_blowoutDurationMax", _maxDur] call VIC_fnc_getSetting;
_dir      = ["VSA_blowoutDirection", _dir] call VIC_fnc_getSetting;
_speedMin = ["VSA_blowoutSpeedMin", _speedMin] call VIC_fnc_getSetting;
_speedMax = ["VSA_blowoutSpeedMax", _speedMax] call VIC_fnc_getSetting;


    ["triggerBlowout"] call VIC_fnc_debugLog;

    if (!isServer) exitWith {
        ["triggerBlowout exit: not server"] call VIC_fnc_debugLog;
    };

    private _duration = _minDur + random (_maxDur - _minDur);

    private _blowoutModule = "diwako_anomalies_main_moduleBlowout" createVehicleLocal [0,0,0];
    _blowoutModule setVariable ["diwako_anomalies_main_wavetime", _duration];
    _blowoutModule setVariable ["diwako_anomalies_main_direction", _dir];
    _blowoutModule setVariable ["diwako_anomalies_main_sirens", true];
    _blowoutModule setVariable ["diwako_anomalies_main_onlyPlayers", true];
    _blowoutModule setVariable ["diwako_anomalies_main_isLethal", true];
    _blowoutModule setVariable ["diwako_anomalies_main_environmentParticleEffects", true];

    private _fncBlowout = missionNamespace getVariable ["diwako_anomalies_main_fnc_moduleBlowout", {}];
    ["init", _blowoutModule] call _fncBlowout;

["triggerBlowout completed"] call VIC_fnc_debugLog;
