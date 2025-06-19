/*
    Returns true if any player is within a given radius of a position.

    Params:
        0: POSITION - location to check
        1: NUMBER   - radius in meters

    Returns: BOOL
*/

params ["_pos", "_radius"];

// Use the activity grid when available for quick lookups
if (!isNil "STALKER_activityGrid") exitWith {
    private _size = missionNamespace getVariable ["STALKER_activityGridSize", 500];
    private _gx = floor ((_pos select 0) / _size);
    private _gy = floor ((_pos select 1) / _size);
    private _key = format ["%1_%2", _gx, _gy];
    private _near = false;
    {
        _x params ["_cell","_state"];
        if (_cell == _key) exitWith { _near = _state; };
    } forEach STALKER_activityGrid;
    _near
};

// Fallback radial search
private _nearby = false;
{
    if (alive _x && { _x distance2D _pos <= _radius }) exitWith { _nearby = true };
} forEach allPlayers;
_nearby;
