/*
    Author: Codex
    Description:
        Periodically schedules psy storms or listens for a manual trigger.
        If a variable name is provided as third parameter the storm will
        also trigger whenever that variable is set to true in the mission
        namespace.

    Params:
        0: NUMBER - minimum delay between storms in seconds (default 1800)
        1: NUMBER - maximum delay between storms in seconds (default 3600)
        2: STRING - missionNamespace variable used for manual trigger (optional)
*/

params [
    ["_minDelay", 1800],
    ["_maxDelay", 3600],
    ["_manualVar", ""]
];

if (_minDelay < 0) then { _minDelay = 0; };
if (_maxDelay < _minDelay) then { _maxDelay = _minDelay; };

[_minDelay, _maxDelay, _manualVar] spawn {
    params ["_min", "_max", "_var"];
    private _nextStorm = time + (_min + random (_max - _min));
    while {true} do {
        if (_var != "" && { missionNamespace getVariable [_var, false] }) then {
            missionNamespace setVariable [_var, false, true];
            [] call AL_fnc_triggerPsyStorm;
            _nextStorm = time + (_min + random (_max - _min));
        };

        if (time >= _nextStorm) then {
            [] call AL_fnc_triggerPsyStorm;
            _nextStorm = time + (_min + random (_max - _min));
        };
        sleep 5;
    };
};
