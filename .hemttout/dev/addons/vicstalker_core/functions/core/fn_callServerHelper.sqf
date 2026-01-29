/*
    Server-side helper executed by VIC_fnc_callServer.
    Params:
        0: CODE   - function to run
        1: ARRAY  - arguments to pass
        2: STRING - result variable name
        3: NUMBER - client owner id
*/
params ["_fnc", ["_args", []], "_var", "_client"];

if (!isServer) exitWith {};

private _result = _args call _fnc;
[_var, _result] remoteExecCall ["VIC_fnc_remoteReturn", _client];

true
