/*
    Finds a hidden spot behind a nearby building from a player's POV.

    Params:
        0: OBJECT - The player to hide from
        1: SCALAR - Search radius from player (default: 100m)
        2: SCALAR - How far behind the building to place the spot (default: 3m)

    Returns:
        POSITION or nil - A valid hidden spot or nil
*/

params ["_player", ["_searchRadius", 100], ["_backOffset", 3]];

if (isNull _player || {!alive _player}) exitWith { nil };

private _playerPos = getPosASL _player;
private _nearBuildings = _playerPos nearObjects ["House", _searchRadius];

{
    private _bPos = getPosASL _x;

    // Vector from player to building
    private _vecToBldg = _bPos vectorDiff _playerPos;
    private _vecNorm = vectorNormalized _vecToBldg;

    // Point behind building
    private _hiddenPos = _bPos vectorAdd (_vecNorm vectorMultiply _backOffset);

    if (
        !surfaceIsWater _hiddenPos &&
        [ _player, "VIEW" ] checkVisibility [ eyePos _player, _hiddenPos ] < 0.05
    ) exitWith {
        _hiddenPos
    };

} forEach _nearBuildings;

nil
