/*
    Returns true if the given position is water.
    Params:
        0: ARRAY - position [x,y,z] or [x,y]
    Returns:
        BOOL - true if water surface
*/
params ["_pos"];
_pos params ["_x","_y",["_z",0]];

private _asl = AGLToASL [_x,_y,_z];
(surfaceIsWater _asl)
