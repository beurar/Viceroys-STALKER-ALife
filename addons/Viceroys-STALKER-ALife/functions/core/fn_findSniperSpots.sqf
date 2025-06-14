/*
    Finds sniper-suitable positions based on elevation, cover, and openness.

    Params:
        0: SCALAR - Minimum elevation in meters (default: 20)
        1: SCALAR - Search radius for cover (default: 15m)
        2: SCALAR - Maximum vegetation nearby (e.g., no dense trees) (default: 10)
        3: SCALAR - Grid step size (default: 300m)

    Returns:
        ARRAY of POSITIONs - Sniper vantage points
*/

params [["_minElev", 20], ["_coverRadius", 15], ["_maxVegetation", 10], ["_step", 300]];

["findSniperSpots"] call VIC_fnc_debugLog;

private _sniperSpots = [];

for "_x" from 0 to worldSize step _step do {
    for "_y" from 0 to worldSize step _step do {
        private _pos = [_x, _y, 0];
        private _elev = getTerrainHeightASL _pos;

        if (_elev < _minElev) then { continue; };

        // Count nearby rocks, walls, or small buildings (sniper cover)
        private _coverObjs = _pos nearObjects ["All", _coverRadius];
        private _cover = _coverObjs select {
            private _t = typeOf _x;
            _t find "Rock" > -1 || _t find "Wall" > -1 || _t find "Stone" > -1 ||
            _t find "Ruins" > -1 || _t find "House" > -1 || _t find "Bunker" > -1
        };

        if ((count _cover) < 1) then { continue; };

        // Check vegetation clutter
        private _vegetation = _coverObjs select {
            private _t = typeOf _x;
            _t find "Tree" > -1 || _t find "Bush" > -1
        };

        if ((count _vegetation) > _maxVegetation) then { continue; };

        _sniperSpots pushBack _pos;
    };
};

_sniperSpots
