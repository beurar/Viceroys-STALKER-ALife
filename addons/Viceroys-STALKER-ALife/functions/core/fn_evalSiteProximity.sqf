/*
    Determines whether a site should be active based on player proximity.
    Applies a 200m hysteresis so active sites only deactivate when all players
    are beyond the activation range plus 200 meters.

    Params:
        0: POSITION - position of the site
        1: NUMBER   - activation range in meters
        2: BOOL     - current active state

    Returns: BOOL - updated active state
*/

params ["_pos", "_range", "_active"];

private _near = [_pos, _range] call VIC_fnc_hasPlayersNearby;

if (_active) then {
    if (!_near) then {
        if !([_pos, _range + 200] call VIC_fnc_hasPlayersNearby) then {
            _active = false;
        } else {
            _active = true;
        };
    };
} else {
    if (_near) then { _active = true; };
};

_active
