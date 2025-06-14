/*
    Scans the map for bridge objects using known classnames.

    Params:
        0: SCALAR - Optional search radius (default: entire map using large grid)
    Returns:
        ARRAY of OBJECTS - All found bridge objects
*/

params [["_step", 1000]];

private _bridgeClassnames = [
    // Add more bridge classnames based on terrain usage
    "Land_Bridge_Asphalt_F",
    "Land_Bridge_01_pathL_F",
    "Land_Bridge_01_pathS_F",
    "Land_Bridge_01_ladder_F",
    "Land_BridgeWooden_01_F",
    "Land_Bridge_Concrete_F",
    "Land_Pier_small_F",               // Often used as makeshift bridges
    "Land_Pier_wall_F",                // Sometimes used structurally
    "Land_nav_pier_m_F"                // Generic piers that can act as bridges
];

private _found = [];

for "_x" from 0 to worldSize step _step do {
    for "_y" from 0 to worldSize step _step do {
        private _center = [_x, _y, 0];
        private _near = _center nearObjects ["All", _step];

        {
            if ((typeOf _x) in _bridgeClassnames) then {
                _found pushBackUnique _x;
            };
        } forEach _near;
    };
};

_found
