/*
    Identifies valley-like positions based on relative terrain elevation.

    Params:
        0: SCALAR - Sampling step size (default: 250m grid)
        1: SCALAR - Elevation threshold in meters to be "lower than surrounding" (default: 15m)

    Returns:
        ARRAY of POSITIONs - Valley center candidates
*/

params [["_step", 250], ["_depthThreshold", 15]];

["findValleys"] call VIC_fnc_debugLog;

private _valleys = [];

for "_x" from 0 to worldSize step _step do {
    for "_y" from 0 to worldSize step _step do {
        private _center = [_x, _y, 0];
        private _centerHeight = getTerrainHeightASL _center;

        private _neighbors = [
            [ _x + _step, _y, 0 ],
            [ _x - _step, _y, 0 ],
            [ _x, _y + _step, 0 ],
            [ _x, _y - _step, 0 ]
        ];

        private _avgNeighborHeight = 0;
        private _validCount = 0;

        {
            if (
                _x inArea [
                    [worldSize/2, worldSize/2, 0],
                    worldSize/2,
                    worldSize/2,
                    0,
                    false
                ]
            ) then {
                _avgNeighborHeight = _avgNeighborHeight + (getTerrainHeightASL _x);
                _validCount = _validCount + 1;
            };
        } forEach _neighbors;

        if (_validCount > 0) then {
            _avgNeighborHeight = _avgNeighborHeight / _validCount;

            if ((_avgNeighborHeight - _centerHeight) > _depthThreshold) then {
                _valleys pushBack _center;
            };
        };
    };
};

_valleys
