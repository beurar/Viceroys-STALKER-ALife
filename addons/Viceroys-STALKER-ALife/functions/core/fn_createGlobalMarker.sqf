/*
    Creates a marker globally on all machines.

    Params:
        0: STRING - marker name
        1: POSITION - marker position
        2: STRING - marker shape  (default "ICON")
        3: STRING - marker type   (default "mil_dot")
        4: STRING - marker color  (default "ColorWhite")
        5: NUMBER - marker alpha  (default 1)
        6: STRING - marker text   (optional)
        7: ARRAY  - marker size   (default [1,1])

    Returns: STRING - marker name
*/
params [
    "_name",
    "_pos",
    ["_shape", "ICON"],
    ["_type", "mil_dot"],
    ["_color", "ColorWhite"],
    ["_alpha", 1],
    ["_text", ""],
    ["_size", [1,1]]
];

if (isNil {_name} || { isNil {_pos} }) exitWith {
    ["createGlobalMarker: missing name or position"] call VIC_fnc_debugLog;
    ""
};

[format ["createGlobalMarker %1 @ %2", _name, _pos]] call VIC_fnc_debugLog;

if (!isServer) exitWith { _name };

[_name, _pos, _shape, _type, _color, _alpha, _text, _size] remoteExecCall ["VIC_fnc_createLocalMarker", 0, true];

[format ["createGlobalMarker done %1", _name]] call VIC_fnc_debugLog;

_name
