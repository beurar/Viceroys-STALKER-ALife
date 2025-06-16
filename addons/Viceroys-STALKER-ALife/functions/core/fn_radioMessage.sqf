/*
    Broadcasts a radio message to all players.

    Params:
        0: STRING - message text
*/
params ["_msg"];

["fn_radioMessage"] call VIC_fnc_debugLog;

if (!hasInterface) exitWith {
    ["fn_radioMessage exit: no interface"] call VIC_fnc_debugLog;
};

player sideChat _msg;

["fn_radioMessage completed"] call VIC_fnc_debugLog;

true
