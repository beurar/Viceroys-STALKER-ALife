/*
    Stores a value in missionNamespace using the provided variable name.
    Params:
        0: STRING - variable name
        1: ANY    - value to assign
*/
params ["_var", "_value"];

missionNamespace setVariable [_var, _value];

true
