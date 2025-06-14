/*
    Trigger a single blowout emission using TTS.
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

if (!isServer) exitWith {};

private _duration = _minDur + random (_maxDur - _minDur);

missionNamespace setVariable ["TTS_EMISSION_DIRECTION", _dir, true];
missionNamespace setVariable ["TTS_EMISSION_DURATION", _duration, true];

// start emission using TTS
tts_emission_randomEmissions = true;
publicVariable "tts_emission_randomEmissions";
[0,0,_speedMin,_speedMax,false] call tts_emission_fnc_startRandomEmissions;

[_duration + 5, {
    tts_emission_randomEmissions = false;
    publicVariable "tts_emission_randomEmissions";
}] call CBA_fnc_waitAndExecute;
