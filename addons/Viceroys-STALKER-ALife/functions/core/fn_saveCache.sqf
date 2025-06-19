/*
    Saves a variable to profileNamespace for persistence.

    Params:
        0: STRING - variable name
        1: ANY    - data to store (defaults to value in mission namespace)

    Returns: BOOL
*/
params ["_name", ["_data", nil]];

if (isNil {_name}) exitWith { false };
if (isNil {_data}) then { _data = missionNamespace getVariable [_name, nil] };
if (isNil {_data}) exitWith { false };

profileNamespace setVariable [_name, _data];
saveProfileNamespace;

private _count = "";
if (_data isEqualType []) then { _count = format [" (%1 items)", count _data]; };
[format ["saveCache %1%2", _name, _count]] call VIC_fnc_debugLog;

true
