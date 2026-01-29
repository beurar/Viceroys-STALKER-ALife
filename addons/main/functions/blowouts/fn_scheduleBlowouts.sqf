/*
    Schedule recurring blowouts using Diwako's Anomalies.
    Params: None
*/


["scheduleBlowouts"] call VIC_fnc_debugLog;

if (!isServer) exitWith {
    ["scheduleBlowouts exit: not server"] call VIC_fnc_debugLog;
};

if (["VSA_enableBlowouts", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["scheduleBlowouts exit: disabled"] call VIC_fnc_debugLog;
};

private _minDelay = ["VSA_blowoutMinDelay",12] call VIC_fnc_getSetting; // hours
private _maxDelay = ["VSA_blowoutMaxDelay",72] call VIC_fnc_getSetting; // hours

if (_maxDelay < _minDelay) then { _maxDelay = _minDelay; };

[_minDelay,_maxDelay] spawn {
    params ["_minH","_maxH"];
    private _next = time + (_minH + random (_maxH - _minH)) * 3600;
    while {true} do {
        if (time >= _next) then {
            [] call VIC_fnc_triggerBlowout;
            _next = time + (_minH + random (_maxH - _minH)) * 3600;
        };
        sleep 60;
    };
};

["scheduleBlowouts completed"] call VIC_fnc_debugLog;
