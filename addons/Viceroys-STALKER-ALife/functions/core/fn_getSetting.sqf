/*
    Wrapper for retrieving a CBA setting with a fallback value.

    Params:
        0: STRING - setting variable name
        1: ANY    - default value if the setting is undefined

    Returns:
        ANY - value of the setting or the provided default
*/
params ["_name", "_default"];

if (isNil "CBA_fnc_getSetting") exitWith { _default };

[_name, _default] call CBA_fnc_getSetting
