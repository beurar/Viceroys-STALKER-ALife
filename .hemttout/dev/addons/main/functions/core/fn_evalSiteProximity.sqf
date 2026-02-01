/*
    Determines whether a site should be active based on player proximity.
    Applies a 200m hysteresis so active sites only deactivate when all players
    are beyond the activation range plus 200 meters.

    Params:
        0: OBJECT or POSITION - anchor object or site position
        1: NUMBER            - activation range in meters
        2: BOOL              - current active state

    Returns: BOOL - updated active state
*/

params ["_anchor", "_range", "_active"];

private _near = [_anchor, _range] call VIC_fnc_hasPlayersNearby;

if (_active) then {
    if (!_near) then {
        if !([_anchor, _range + 200] call VIC_fnc_hasPlayersNearby) then {
            _active = false;
        } else {
            _active = true;
        };
    };
} else {
    if (_near) then { _active = true; };
};

_active
