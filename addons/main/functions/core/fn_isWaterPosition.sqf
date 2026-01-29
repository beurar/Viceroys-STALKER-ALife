/*
    Returns true if the given position is water.
    Params:
        0: ARRAY or OBJECT - position [x,y,z] or object
    Returns:
        BOOL - true if water surface
*/

// allow passing an object directly
private _pos = if (_this isEqualType objNull) then { getPos _this } else { _this };
if !(_pos isEqualType []) exitWith { false };
if ((count _pos) < 2) exitWith { false };

_pos params [["_x",0],["_y",0],["_z",0]];

private _surf = [[_x,_y,_z]] call VIC_fnc_getSurfacePosition;
(ASLToAGL _surf select 2) <= 0
