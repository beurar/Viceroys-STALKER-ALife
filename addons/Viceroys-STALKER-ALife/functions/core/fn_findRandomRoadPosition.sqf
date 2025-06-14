/*
    Finds a valid road position near a random point on the map.

    Params:
        0: SCALAR - Search radius around the random point (e.g., 300)
        1: SCALAR - Max number of attempts (e.g., 20)

    Returns:
        POSITION - Road position [x, y, z], or nil if none found
*/
params [["_radius", 300], ["_maxTries", 20]];

private _attempt = 0;
private _worldSize = worldSize;

while { _attempt < _maxTries } do {
    private _x = random _worldSize;
    private _y = random _worldSize;
    private _randomPos = [_x, _y, 0];

    private _searchCenter = _randomPos;
    private _roadPos = _searchCenter findEmptyPosition [_radius, _radius, "ROAD"];

    if (!(_roadPos isEqualTo []) && { isOnRoad _roadPos }) exitWith {
        _roadPos
    };

    _attempt = _attempt + 1;
};

nil
