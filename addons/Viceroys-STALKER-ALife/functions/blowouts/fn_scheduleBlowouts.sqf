/*
    Schedule recurring blowout emissions using TTS.
    Params: None
*/

["scheduleBlowouts"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableBlowouts", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

private _minDelay = ["VSA_blowoutMinDelay",12] call VIC_fnc_getSetting; // hours
private _maxDelay = ["VSA_blowoutMaxDelay",72] call VIC_fnc_getSetting; // hours
private _minDur   = ["VSA_blowoutDurationMin",300] call VIC_fnc_getSetting;
private _maxDur   = ["VSA_blowoutDurationMax",900] call VIC_fnc_getSetting;
private _dir      = ["VSA_blowoutDirection",0] call VIC_fnc_getSetting;
private _speedMin = ["VSA_blowoutSpeedMin",125] call VIC_fnc_getSetting;
private _speedMax = ["VSA_blowoutSpeedMax",125] call VIC_fnc_getSetting;

if (_maxDelay < _minDelay) then { _maxDelay = _minDelay; };

[_minDelay,_maxDelay,_minDur,_maxDur,_dir,_speedMin,_speedMax] spawn {
    params ["_minH","_maxH","_dMin","_dMax","_dir","_sMin","_sMax"];
    private _next = time + (_minH + random (_maxH - _minH)) * 3600;
    while {true} do {
        if (time >= _next) then {
            [_dMin,_dMax,_dir,_sMin,_sMax] call VIC_fnc_triggerBlowout;
            _next = time + (_minH + random (_maxH - _minH)) * 3600;
        };
        sleep 60;
    };
};
