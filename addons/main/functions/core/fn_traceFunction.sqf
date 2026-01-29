/*
    Wraps a function with debug logging for entry and exit.

    Params:
        0: CODE   - original function
        1: STRING - function name for logging

    Returns:
        CODE - wrapped function
*/
params ["_fn", "_name"];

private _id  = str floor (diag_tickTime * 1e6);
private _var = format ["VIC_trace_%1", _id];

missionNamespace setVariable [_var, [_fn, _name]];

compileFinal format ["
    private _args = _this;
    private _data = missionNamespace getVariable ['%1', []];
    private _fn = _data select 0;
    private _fnName = _data select 1;

    if (['VSA_debugMode', false] call VIC_fnc_getSetting) then {
        [(_fnName + ' called with ' + str _args)] call VIC_fnc_debugLog;
    };

    private _result = _args call _fn;

    if (['VSA_debugMode', false] call VIC_fnc_getSetting) then {
        [(_fnName + ' returned ' + str _result)] call VIC_fnc_debugLog;
    };

    _result
", _var]
