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

if (isNil "STALKER_roads" || { STALKER_roads isEqualTo [] }) then {
    STALKER_roads = [] call VIC_fnc_findRoads;
};

private _attempt = 0;

while { _attempt < _maxTries } do {
    private _angle = random 360;
    private _dist  = random _radius;

    private _candidatePos = _centerPos getPos [_dist, _angle];
    private _roads = STALKER_roads select { _x distance2D _candidatePos < 50 };
    if (!(_roads isEqualTo [])) exitWith { selectRandom _roads };

    _attempt = _attempt + 1;
};

nil
