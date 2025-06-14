/*
    Broadcasts a radio message to all players.

    Params:
        0: STRING - message text
*/
params ["_msg"];

if (!hasInterface) exitWith {};

player sideChat _msg;

true
