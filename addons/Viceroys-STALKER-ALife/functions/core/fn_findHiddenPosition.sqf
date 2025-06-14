/*
    Finds a hidden position within a given radius of any player,
    that is not visible to any of them.

    Params:
        0: SCALAR - Search radius around each player (default: 300m)
        1: SCALAR - Number of samples to test per player (default: 50)

    Returns:
        POSITION or nil - A spot unseen by any player, or nil if none found
*/

params [["_radius", 300], ["_samples", 50]];

private _players = allPlayers select { alive _x && {!isNull _x} };
private _validSpots = [];

{
    private _playerPos = getPosASL _x;

    for "_i" from 1 to _samples do {
        private _angle = random 360;
        private _dist  = random _radius;
        private _pos = _playerPos vectorAdd [
            _dist * cos _angle,
            _dist * sin _angle,
            0
        ];

        // Skip spots in the air or water
        if (surfaceIsWater _pos) then { continue; };

        // Check visibility from each player
        private _seen = false;

        {
            if ([ _x, "VIEW" ] checkVisibility [ eyePos _x, _pos ] > 0.1) exitWith {
                _seen = true;
            };
        } forEach _players;

        if (!_seen) then {
            _validSpots pushBack _pos;
        };
    };
} forEach _players;

if (_validSpots isNotEqualTo []) then {
    selectRandom _validSpots
} else {
    nil
}
