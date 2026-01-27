/*
    Returns active spatial cells near players
*/

private _cellSize = 1000;
private _radiusCells = 2; // 2 cells ≈ 2km radius

private _cells = [];

{
    private _pos = getPosATL _x;
    private _cx = floor ((_pos#0) / _cellSize);
    private _cy = floor ((_pos#1) / _cellSize);

    for "_xoff" from -_radiusCells to _radiusCells do {
        for "_yoff" from -_radiusCells to _radiusCells do {
            private _id = format ["%1_%2", _cx + _xoff, _cy + _yoff];
            _cells pushBackUnique _id;
        };
    };
} forEach allPlayers;

_cells
