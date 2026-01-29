/*
    Returns the surface position for the given coordinates, ensuring it is on land.
    Params:
        0: ARRAY - position [x,y] or [x,y,z]
    Returns:
        ARRAY - position ASL on land or [] if water
*/
params ["_pos"];

private _surf = [_pos] call VIC_fnc_getSurfacePosition;
if ((ASLToAGL _surf) call VIC_fnc_isWaterPosition) exitWith { [] };
_surf
