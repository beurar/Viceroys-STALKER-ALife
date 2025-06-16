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

if (!isServer) exitWith {
    ["triggerBlowout exit: not server"] call VIC_fnc_debugLog;
};

// ensure the TTS emission module is loaded
if (isNil "tts_emission_fnc_startEmission") exitWith {
    ["TTS emission module missing, aborting blowout"] call VIC_fnc_debugLog;
};

private _duration = _minDur + random (_maxDur - _minDur);

missionNamespace setVariable ["TTS_EMISSION_DIRECTION", _dir, true];
missionNamespace setVariable ["TTS_EMISSION_DURATION", _duration, true];

// configure TTS emission behaviour
tts_emission_playerEffect      = 0; // kill unsheltered players
private _killAI                = ["VSA_killAIEmission", true] call VIC_fnc_getSetting;
tts_emission_aiEffect          = if (_killAI) then {0} else {1};
tts_emission_vehicleEffect     = 3; // disable engines
tts_emission_aircraftEffect    = 0; // lightning strike
tts_emission_sirenType         = 0; // classic siren
tts_emission_useSirenObject    = false;
tts_emission_protectionEquipment = [];
tts_emission_shelterTypes      = ["Building","Car","Tank","Air","Ship"];
tts_emission_immuneUnits       = [];
tts_emission_waveSpeed         = _speedMin;
tts_emission_approachDirection = switch (true) do {
    case (_dir <= 45 || _dir > 315): {"N"};
    case (_dir > 45 && _dir <= 135): {"E"};
    case (_dir > 135 && _dir <= 225): {"S"};
    default {"W"};
};
tts_emission_showEmissionOnMap = false;
tts_emission_disableRain       = false;

// start emission using TTS
[] spawn tts_emission_fnc_startEmission;

["triggerBlowout completed"] call VIC_fnc_debugLog;
