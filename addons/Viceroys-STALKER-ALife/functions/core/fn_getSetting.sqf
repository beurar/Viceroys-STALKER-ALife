/*
    Wrapper for retrieving a CBA setting with a fallback value.

    Params:
        0: STRING - setting variable name
        1: ANY    - default value if the setting is undefined

    Returns:
        ANY - value of the setting or the provided default
*/
params ["_name", "_default"];

if (isNil "CBA_fnc_getSetting") exitWith {
    [format ["getSetting: CBA missing for %1", _name]] call VIC_fnc_debugLog;
    _default
};

private _value = [_name, _default] call CBA_fnc_getSetting;
[format ["getSetting: %1 -> %2", _name, _value]] call VIC_fnc_debugLog;
_value
