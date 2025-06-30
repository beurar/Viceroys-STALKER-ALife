/*
    Checks if a candidate stalker camp position is far enough from existing camps.

    Params:
        0: POSITION - position to test
        1: NUMBER   - minimum separation distance (default 300m)

    Returns:
        BOOL - true if no existing camp is within the distance
*/

params ["_pos", ["_dist", 300]];

if (isNil "STALKER_camps") exitWith { true };

{
    if (_pos distance2D (_x select 2) < _dist) exitWith { false };
} forEach STALKER_camps;

true
