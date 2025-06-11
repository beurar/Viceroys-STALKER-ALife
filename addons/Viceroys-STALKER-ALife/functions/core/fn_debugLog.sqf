/*
    Logs a debug message to the RPT and as a system chat message when
    VSA_debugMode is enabled via CBA settings.

    Params:
        0: STRING - message to display
*/
params ["_msg"];

if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
    diag_log _msg;
    if (hasInterface) then {
        systemChat _msg;
    };
};

true
