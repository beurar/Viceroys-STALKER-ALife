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
    _road = nearestRoad _center;
};

private _pos = _center;
if (!isNull _road) then {
    _pos = getPos _road;
};

private _ied = createMine ["IEDLandSmall_F", _pos, [], 0];

[_ied];
