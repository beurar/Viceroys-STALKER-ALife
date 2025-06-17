/*
    Logs a debug message to the RPT and as a system chat message when
    VSA_debugMode is enabled via CBA settings.

    Params:
        0: STRING - message to display
*/
params ["_msg"];

// When the settings function isn't available yet (e.g. early in init)
// assume debug mode is enabled so logging still works
private _enabled = true;
if (!isNil "CBA_fnc_getSetting") then {
    _enabled = ["VSA_debugMode", false] call CBA_fnc_getSetting;
};

if (_enabled) then {
    diag_log str _msg;
    if (hasInterface) then {
        systemChat str _msg;
    };
};

true
