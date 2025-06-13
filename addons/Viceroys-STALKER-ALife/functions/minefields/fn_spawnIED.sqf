/*
    Spawns a single IED on a road near the given position.
    Params:
        0: POSITION - position to search
    Returns:
        ARRAY - array containing the spawned IED object
*/
params ["_center"];

["spawnIED"] call VIC_fnc_debugLog;

if (!isServer) exitWith { [] };

private _road = roadAt _center;
if (isNull _road) then {
    private _radius = 50;
    private _max = 200;
    while {isNull _road && {_radius <= _max}} do {
        private _roads = _center nearRoads _radius;
        if (!(_roads isEqualTo [])) then {
            _road = _roads select 0;
        };
        _radius = _radius + 50;
    };
    if (isNull _road) then {
        _road = nearestRoad _center;
    };
};

if (isNull _road) exitWith { [] };

private _pos = getPos _road;
private _ied = createMine ["IEDLandSmall_F", _pos, [], 0];

[_ied];
