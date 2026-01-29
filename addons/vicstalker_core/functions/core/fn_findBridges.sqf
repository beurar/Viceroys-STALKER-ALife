/*
    Scans the entire map for bridge-like objects using classnames and model path heuristics.

    Params:
        0: SCALAR - Grid cell step size (default: 1000m)
    Returns:
        ARRAY of OBJECTS - All found bridge objects
*/

params [["_step", 1000]];

private _bridgeClassnames = [
    "Land_Bridge_Asphalt_F",
    "Land_Bridge_01_pathL_F",
    "Land_Bridge_01_pathS_F",
    "Land_Bridge_01_ladder_F",
    "Land_BridgeWooden_01_F",
    "Land_Bridge_Concrete_F",
    "Land_CHR_asf1_25",
    "Land_CHR_asf3_25",
    "Land_Bridge_stone_asf2_25",
    "Land_Pier_small_F",
    "Land_Pier_wall_F",
    "Land_nav_pier_m_F"
];

private _found = [];
private _halfStep = _step / 2;

// Map bounds
private _size = worldSize;

// Loop over the grid
for "_x" from 0 to _size step _step do {
    for "_y" from 0 to _size step _step do {
        private _center = [_x + _halfStep, _y + _halfStep, 0];

        private _nearObjs = _center nearObjects ["All", _step];
        private _nearTerrain = nearestTerrainObjects [_center, ["BUILDING", "STRUCTURE", "WALL"], _step];
        private _combined = _nearObjs + _nearTerrain;

        {
            private _obj = _x;
            private _type = typeOf _obj;
            private _model = toLower ((getModelInfo _obj) select 0);

            if (
                _type in _bridgeClassnames ||
                {"bridge" in _model || "pier" in _model}
            ) then {
                _found pushBackUnique _obj;
            };
        } forEach _combined;
    };
};

// Cache results for later use
if (isNil "STALKER_bridges") then { STALKER_bridges = [] };
{ STALKER_bridges pushBackUnique _x } forEach _found;

[format ["findBridges: %1 cached", count STALKER_bridges]] call VIC_fnc_debugLog;

_found
