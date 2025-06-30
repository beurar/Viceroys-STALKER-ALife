/*
    Returns true if any player is within a given radius of an anchor position.

    Params:
        0: OBJECT or POSITION - anchor to query
        1: NUMBER   - radius in meters

    Returns: BOOL
*/

params ["_anchor", "_radius"];

// Use nearEntities on the supplied anchor for efficient lookups
private _units = _anchor nearEntities ["CAManBase", _radius];
private _nearby = count (_units select { isPlayer _x && alive _x }) > 0;
_nearby;
