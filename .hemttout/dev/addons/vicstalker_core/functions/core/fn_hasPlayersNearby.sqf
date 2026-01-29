/*
    Returns true if any player is within a given radius of an anchor position.

    Params:
        0: OBJECT or POSITION - anchor to query
        1: NUMBER   - radius in meters

    Returns: BOOL
*/

params ["_anchor", "_radius"];

// Resolve the anchor to a position for consistent checks
private _pos = if (_anchor isEqualType objNull) then { getPosATL _anchor } else { _anchor };
// Use nearEntities on the resolved position for efficient lookups
private _units = _pos nearEntities ["CAManBase", _radius];
private _nearby = (_units select { isPlayer _x && alive _x }) isNotEqualTo [];
_nearby;
