/*
    Finds a land position using VIC_fnc_findLandAGL on the server and returns it.
    Params: see VIC_fnc_findLandAGL
    Returns: ARRAY - AGL ground position or [] if none found
*/
params ["_center", ["_radius",50], ["_attempts",10], ["_excludeTowns", false], ["_maxRadius", -1]];

[VIC_fnc_findLandAGL, [_center, _radius, _attempts, _excludeTowns, _maxRadius]] call VIC_fnc_callServer;
