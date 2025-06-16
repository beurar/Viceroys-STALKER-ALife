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

private _marker = createMarker [_name, _pos];
_marker setMarkerShape _shape;
_marker setMarkerSize _size;
_marker setMarkerType _type;
_marker setMarkerColor _color;
_marker setMarkerAlpha _alpha;
if (_text != "") then {
    _marker setMarkerText _text;
};
_marker
