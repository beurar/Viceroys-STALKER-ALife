/*
    Returns true if any player is within a given radius of a position.

    Params:
        0: POSITION - location to check
        1: NUMBER   - radius in meters

    Returns: BOOL
*/

params ["_pos", "_radius"];

// Search all players on the server and return true when one is close
(allPlayers findIf { alive _x && {_x distance2D _pos <= _radius} }) >= 0
