/*
    Returns the 3D ASL position at the surface (terrain or object) for the given 2D position.

    Params:
        0: ARRAY - position [x,y] or [x,y,z] (z ignored)

    Returns:
        ARRAY - position ASL on surface
*/
params ["_pos"];
_pos params ["_x","_y",["_z",0]];

private _from = [_x, _y, 50];
private _to   = [_x, _y, -50];

private _hit = lineIntersectsSurfaces [_from, _to, objNull, objNull, true, 1, "GEOM", "NONE"];
if (_hit isEqualTo []) exitWith { AGLToASL [_x, _y, 0] };

(_hit select 0) select 0
