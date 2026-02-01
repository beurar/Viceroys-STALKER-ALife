/*
    Returns a random cached road position, populating the cache if required.

    Returns:
        POSITION - road position [x, y, z]
*/

if (isNil "STALKER_roads" || { STALKER_roads isEqualTo [] }) then {
    STALKER_roads = [] call VIC_fnc_findRoads;
};

selectRandom STALKER_roads
