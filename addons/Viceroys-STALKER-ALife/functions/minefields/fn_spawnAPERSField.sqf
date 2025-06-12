/*
    Spawns a square APERS minefield.
    Params:
        0: POSITION - center position
        1: NUMBER   - side length in meters (default 30)
    Returns:
        ARRAY - spawned mine objects
*/
params ["_center", ["_size",30]];

["spawnAPERSField"] call VIC_fnc_debugLog;

if (!isServer) exitWith { [] };

private _objs = [];
private _half = _size / 2;
private _spacing = 5;

for "_xOff" from -_half to _half step _spacing do {
    for "_yOff" from -_half to _half step _spacing do {
        private _pos = [(_center select 0) + _xOff, (_center select 1) + _yOff, 0];
        _pos = [_pos] call VIC_fnc_findLandPosition;
        if (_pos isEqualTo []) then { continue };
        private _mine = createMine ["APERSMine", _pos, [], 0];
        _objs pushBack _mine;
    };
};
_objs

