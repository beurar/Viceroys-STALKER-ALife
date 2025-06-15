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

[_name, _pos] remoteExec ["createMarker", 0];
[_name, _shape] remoteExec ["setMarkerShape", 0];
[_name, _type] remoteExec ["setMarkerType", 0];
[_name, _color] remoteExec ["setMarkerColor", 0];
[_name, _alpha] remoteExec ["setMarkerAlpha", 0];
if (_text != "") then {
    [_name, _text] remoteExec ["setMarkerText", 0];
};

[format ["createGlobalMarker done %1", _name]] call VIC_fnc_debugLog;

_name
