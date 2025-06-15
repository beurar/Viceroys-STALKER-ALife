/*
    Wraps a function with debug logging for entry and exit.

    Params:
        0: CODE   - original function
        1: STRING - function name for logging

    Returns:
        CODE - wrapped function
*/
params ["_fn", "_name"];

private _function = _fn;

{
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        [format ["%1 called with %2", _name, str _this]] call VIC_fnc_debugLog;
    };
    private _result = _this call _function;
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        [format ["%1 returned %2", _name, str _result]] call VIC_fnc_debugLog;
    };
    _result
}
