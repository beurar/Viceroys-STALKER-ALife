/*
    Returns true if the given position is water.
    Params:
        0: ARRAY - position [x,y,z] or [x,y]
    Returns:
        BOOL - true if water surface
*/
// Accepts either [x,y] or [x,y,z] and normalises to 3D
params ["_x","_y",["_z",0]];

private _asl = AGLToASL [_x,_y,_z];
(surfaceIsWater _asl)
