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

["schedulePsyStorms"] call VIC_fnc_debugLog;

if (["VSA_enableStorms", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

private _interval = ["VSA_stormInterval", 30] call VIC_fnc_getSetting;
private _spawnWeight = ["VSA_stormSpawnWeight", 50] call VIC_fnc_getSetting;
private _nightOnly = ["VSA_stormsNightOnly", false] call VIC_fnc_getSetting;

_minDelay = ["VSA_stormMinDelay", _minDelay] call VIC_fnc_getSetting;
_maxDelay = ["VSA_stormMaxDelay", _maxDelay] call VIC_fnc_getSetting;

if (_minDelay < 0) then { _minDelay = 0; };
if (_maxDelay < _minDelay) then { _maxDelay = _minDelay; };

[_minDelay, _maxDelay, _manualVar, _spawnWeight, _nightOnly] spawn {
    params ["_min", "_max", "_var", "_weight", "_night"];
    private _nextStorm = time + (_min + random (_max - _min));
    while {true} do {
        if (_var != "" && { missionNamespace getVariable [_var, false] }) then {
            missionNamespace setVariable [_var, false, true];
            if (random 100 < _weight && { !(_night && daytime > 5 && daytime < 20) }) then {
                [] call VIC_fnc_triggerPsyStorm;
            };
            _nextStorm = time + (_min + random (_max - _min));
        };

        if (time >= _nextStorm) then {
            if (random 100 < _weight && { !(_night && daytime > 5 && daytime < 20) }) then {
                [] call VIC_fnc_triggerPsyStorm;
            };
            _nextStorm = time + (_min + random (_max - _min));
        };
        sleep 5;
    };
};
