/*
    Finds a valid road position near a specified position.

    Params:
        0: POSITION - The center position to search around
        1: SCALAR   - Radius to search within (e.g., 300)
        2: SCALAR   - Max number of attempts (e.g., 20)

    Returns:
        POSITION - Road position [x, y, z], or nil if none found
*/
params ["_centerPos", ["_radius", 300], ["_maxTries", 20]];

private _attempt = 0;

while { _attempt < _maxTries } do {
    private _angle = random 360;
    private _dist = random _radius;

    private _offset = [
        (_dist * cos _angle),
        (_dist * sin _angle),
        0
    ];
    private _candidatePos = _centerPos vectorAdd _offset;

    private _roadPos = _candidatePos findEmptyPosition [10, 50, "ROAD"];

    if (!(_roadPos isEqualTo []) && { isOnRoad _roadPos }) exitWith {
        _roadPos
    };

    _attempt = _attempt + 1;
};

nil
