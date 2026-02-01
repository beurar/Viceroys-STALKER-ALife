/*
    Loads a cached variable from profileNamespace if available.

    Params:
        0: STRING - variable name

    Returns: ANY - loaded value or nil when absent
*/
params ["_name"];

private _data = nil;
if (isNil {_name}) exitWith { _data };

private _key = format ["%1_%2", worldName, _name];
_data = profileNamespace getVariable [_key, nil];
if (!isNil {_data}) then {
    missionNamespace setVariable [_name, _data];
    private _count = "";
    if (_data isEqualType []) then { _count = format [" (%1 items)", count _data]; };
    [format ["loadCache %1%2", _key, _count]] call VIC_fnc_debugLog;
} else {
    [format ["loadCache %1: none", _key]] call VIC_fnc_debugLog;
};

_data
