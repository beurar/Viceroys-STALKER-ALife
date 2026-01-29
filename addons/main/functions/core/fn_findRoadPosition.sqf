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
_maxTries; // parameter kept for backward compatibility

if (isNil "STALKER_roads" || { STALKER_roads isEqualTo [] }) then {
    STALKER_roads = [] call VIC_fnc_findRoads;
};

private _roads = STALKER_roads select { _x distance2D _centerPos <= _radius };
if (!(_roads isEqualTo [])) exitWith { selectRandom _roads };

[] call VIC_fnc_getRandomRoad


