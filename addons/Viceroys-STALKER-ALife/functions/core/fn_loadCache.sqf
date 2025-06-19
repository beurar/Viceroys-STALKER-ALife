/*
    Loads a cached variable from profileNamespace if available.

    Params:
        0: STRING - variable name

    Returns: ANY - loaded value or nil when absent
*/
params ["_name"];

if (isNil {_name}) exitWith { nil };

private _data = profileNamespace getVariable [_name, nil];
if (!isNil {_data}) then {
    missionNamespace setVariable [_name, _data];
    private _count = "";
    if (_data isEqualType []) then { _count = format [" (%1 items)", count _data]; };
    [format ["loadCache %1%2", _name, _count]] call VIC_fnc_debugLog;
} else {
    [format ["loadCache %1: none", _name]] call VIC_fnc_debugLog;
};

_data
