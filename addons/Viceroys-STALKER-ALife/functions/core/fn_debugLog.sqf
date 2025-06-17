/*
    Logs a debug message to the RPT and as a system chat message when
    VSA_debugMode is enabled. Debug mode defaults to enabled during
    testing.

    Params:
        0: STRING - message to display
*/
params ["_msg"];

private _enabled = missionNamespace getVariable ["VSA_debugMode", true];

if (_enabled) then {
    diag_log str _msg;
    if (hasInterface) then {
        systemChat str _msg;
    };
};

true
