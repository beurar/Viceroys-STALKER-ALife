/*
    Performs a grid search across the entire map to locate road positions.

    Params:
        0: NUMBER - grid step size in meters (default: 25)

    Returns:
        ARRAY of positions on roads in AGL coordinates
*/
params [["_step", 25]];

["findRoads"] call VIC_fnc_debugLog;

private _roads = [];

for "_xCoord" from 0 to worldSize step _step do {
    for "_yCoord" from 0 to worldSize step _step do {
        private _pos = [_xCoord, _yCoord, 0];
        if (isOnRoad _pos) then {
            private _surf = [_pos] call VIC_fnc_getSurfacePosition;
            _roads pushBack (ASLToAGL _surf);
        };
    };
};

["findRoads completed"] call VIC_fnc_debugLog;

// Cache results for later use
if (isNil "STALKER_roads") then { STALKER_roads = [] };
{ STALKER_roads pushBackUnique _x } forEach _roads;

[format ["findRoads: %1 cached", count STALKER_roads]] call VIC_fnc_debugLog;

_roads

