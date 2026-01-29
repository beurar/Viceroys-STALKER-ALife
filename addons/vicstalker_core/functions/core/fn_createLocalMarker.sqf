/*
    Creates a marker locally with the given attributes.

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

if (
    isNil {_name} || { isNil {_pos} } ||
    { !(_pos isEqualType []) } || { (count _pos) < 2 }
) exitWith {
    ["createLocalMarker: missing name or position"] call VIC_fnc_debugLog;
    ""
};

private _marker = createMarkerLocal [_name, _pos];
_marker setMarkerShapeLocal _shape;
_marker setMarkerSizeLocal _size;
_marker setMarkerTypeLocal _type;
_marker setMarkerColorLocal _color;
_marker setMarkerAlphaLocal _alpha;
if (_text != "") then {
    _marker setMarkerTextLocal _text;
};
_marker
