/*
    Spawns a circular APERS minefield.
    Params:
        0: POSITION - center position
        1: NUMBER   - radius in meters (default 30)
    Returns:
        ARRAY - spawned mine objects
*/
params ["_center", ["_radius",30]];

["spawnAPERSField"] call VIC_fnc_debugLog;

if (!isServer) exitWith { [] };

private _objs = [];
private _spacing = 5;

for "_xOff" from -_radius to _radius step _spacing do {
    for "_yOff" from -_radius to _radius step _spacing do {
        if ((_xOff * _xOff + _yOff * _yOff) > (_radius * _radius)) then { continue; };
        private _pos = [(_center select 0) + _xOff, (_center select 1) + _yOff, 0];
        _pos = [_pos] call VIC_fnc_findLandPos;
        if (isNil {_pos} || {_pos isEqualTo []}) then { continue; };
        private _mine = createMine ["APERSMine", _pos, [], 0];
        _objs pushBack _mine;
    };
};
_objs

