/*
    Scans the map for water positions that have nearby land, roughly indicating a beach.

    Params:
        0: NUMBER - grid step size in meters (default: 200)
        1: NUMBER - distance to check for land (default: 40)

    Returns:
        ARRAY of positions in AGL coordinates representing beach spots
*/
params [["_step", 200], ["_distance", 40]];

private _spots = [];

for "_xCoord" from 0 to worldSize step _step do {
    for "_yCoord" from 0 to worldSize step _step do {
        private _pos = [_xCoord, _yCoord, 0];
        if ([_pos] call VIC_fnc_isWaterPosition) then {
            private _landNearby = false;
            {
                private _test = [_pos, _distance, _x] call BIS_fnc_relPos;
                if (!([_test] call VIC_fnc_isWaterPosition)) exitWith { _landNearby = true };
            } forEach [0, 90, 180, 270];
            if (_landNearby) then {
                private _surf = [_pos] call VIC_fnc_getSurfacePosition;
                _spots pushBack (ASLToAGL _surf);
            };
        };
    };
};

_spots
