/*
    Queues mine spawning instead of instant spawn
*/

params ["_center", "_radius", "_type"];

if (isNil "STALKER_spawnQueue") then {
    STALKER_spawnQueue = [];
};

private _positions = [];

for "_i" from 1 to (5 + floor random 5) do {
    private _pos = _center getPos [random _radius, random 360];
    if (!surfaceIsWater _pos) then {
        _positions pushBack _pos;
    };
};

STALKER_spawnQueue pushBack [_type, _positions];

_positions
