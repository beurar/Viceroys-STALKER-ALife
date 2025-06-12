/*
    Returns true if any player is within a given radius of a position.

    Params:
        0: POSITION - position to check
        1: NUMBER   - radius in meters (defaults to VSA_playerNearbyRange)

    Returns:
        BOOL - true when a player is nearby
*/
private _default = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;
params [
    ["_pos", [0,0,0]],
    ["_radius", _default]
];

(allPlayers findIf { _x distance2D _pos <= _radius } > -1)
