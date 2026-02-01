/*
    Executes the given code on the server and returns the result.
    Params:
        0: CODE  - function to run remotely
        1: ARRAY - arguments to pass (default [])
    Returns: ANY - value returned by the function
*/
params ["_fnc", ["_args", []]];

if (isServer) exitWith { _args call _fnc };

private _var = format ["VIC_res_%1_%2", clientOwner, diag_tickTime];
missionNamespace setVariable [_var, nil];

[_fnc, _args, _var, clientOwner] remoteExec ["VIC_fnc_callServerHelper", 2];

waitUntil { !isNil { missionNamespace getVariable _var } };

private _result = missionNamespace getVariable _var;
missionNamespace setVariable [_var, nil];

_result
