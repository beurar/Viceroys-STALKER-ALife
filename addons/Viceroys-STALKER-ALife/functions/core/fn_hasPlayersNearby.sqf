/*
    Returns true if any player is within a given radius of a position.

    Params:
        0: POSITION - location to check
        1: NUMBER   - radius in meters

    Returns: BOOL
*/

params ["_pos", "_radius"];

// Simple radial search around the position
private _nearby = false;
{
    if (alive _x && { _x distance2D _pos <= _radius }) exitWith { _nearby = true };
} forEach allPlayers;
_nearby;
