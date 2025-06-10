/*
    Returns true if any player is within a given radius of a position.

    Params:
        0: POSITION - position to check
        1: NUMBER   - radius in meters (default 1500)

    Returns:
        BOOL - true when a player is nearby
*/
params [
    ["_pos", [0,0,0]],
    ["_radius", 1500]
];

(allPlayers findIf { _x distance2D _pos <= _radius } > -1)
