/*
    Creates a marker globally on all machines.

    Params:
        0: STRING - marker name
        1: POSITION - marker position
        2: STRING - marker shape (default "ICON")
        3: STRING - marker type  (default "mil_dot")
        4: STRING - marker color (default "ColorWhite")
        5: NUMBER - marker alpha (default 1)
        6: STRING - marker text  (optional)

    Returns: STRING - marker name
*/
params ["_name", "_pos", ["_shape", "ICON"], ["_type", "mil_dot"], ["_color", "ColorWhite"], ["_alpha", 1], ["_text", ""]];

[format ["createGlobalMarker %1 @ %2", _name, _pos]] call VIC_fnc_debugLog;

if (!isServer) exitWith { _name };

[_name, _pos] remoteExecCall ["createMarker", 0, true];
[_name, _shape] remoteExecCall ["setMarkerShape", 0, true];
[_name, _type] remoteExecCall ["setMarkerType", 0, true];
[_name, _color] remoteExecCall ["setMarkerColor", 0, true];
[_name, _alpha] remoteExecCall ["setMarkerAlpha", 0, true];
if (_text != "") then {
    [_name, _text] remoteExecCall ["setMarkerText", 0, true];
};

[format ["createGlobalMarker done %1", _name]] call VIC_fnc_debugLog;

_name
