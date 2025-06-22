/*
    Returns true if any player is within a given radius of a position.

    Params:
        0: POSITION - location to check
        1: NUMBER   - radius in meters

    Returns: BOOL
*/

params ["_pos", "_radius"];

// Use the activity grid when available for quick lookups
if (!isNil "STALKER_activityGrid") then {
    private _size = missionNamespace getVariable ["STALKER_activityGridSize", 500];
    private _max  = floor (worldSize / _size);
    private _gx = floor ((_pos select 0) / _size);
    private _gy = floor ((_pos select 1) / _size);
    if (_gx >= 0 && {_gx <= _max} && {_gy >= 0} && {_gy <= _max}) then {
        private _idx = _gx * (_max + 1) + _gy;
        private _entry = STALKER_activityGrid select _idx;
        if (!isNil "_entry") exitWith { _entry select 1 };
    };
};

// Fallback radial search
private _nearby = false;
{
    if (alive _x && { _x distance2D _pos <= _radius }) exitWith { _nearby = true };
} forEach allPlayers;
_nearby;
