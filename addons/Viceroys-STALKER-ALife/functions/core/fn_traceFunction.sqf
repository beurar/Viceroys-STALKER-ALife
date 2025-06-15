/*
    Wraps a function with debug logging for entry and exit.

    Params:
        0: CODE   - original function
        1: STRING - function name for logging

    Returns:
        CODE - wrapped function
*/
params ["_fn", "_name"];

// Store the function and name under a unique identifier so the generated
// wrapper can retrieve them when executed. SQF lacks closures, so this
// approach avoids undefined-variable errors.
// diag_tickTime may include decimal places which are invalid in variable names.
// Multiply and floor to generate a numeric identifier and convert to string.
private _id  = str floor (diag_tickTime * 1e6);
private _var = format ["VIC_trace_%1", _id];

missionNamespace setVariable [_var, [_fn, _name]];

compileFinal format ["\
    private _args = _this;\n\
    private _data = missionNamespace getVariable ['%1', []];\n\
    private _fn = _data select 0;\n\
    private _fnName = _data select 1;\n\
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {\n\
        [(_fnName + ' called with ' + str _args)] call VIC_fnc_debugLog;\n\
    };\n\
    private _result = _args call _fn;\n\
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {\n\
        [(_fnName + ' returned ' + str _result)] call VIC_fnc_debugLog;\n\
    };\n\
    _result\n\
", _var]
