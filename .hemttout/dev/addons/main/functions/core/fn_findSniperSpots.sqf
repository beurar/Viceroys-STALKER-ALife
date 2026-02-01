/*
    Finds sniper vantage points by firing multiple vertical rays onto each
    building. The highest impact position from each ray burst becomes a
    potential sniper spot.

    Params:
        0: SCALAR - Number of rays to cast per building (default: 8)
        1: SCALAR - Scatter radius around the building center (default: 5m)

    Returns:
        ARRAY of POSITIONs - Sniper vantage points on rooftops
*/

params [["_raysPerBuilding", 8], ["_spread", 5]];

["findSniperSpots"] call VIC_fnc_debugLog;

private _sniperSpots = [];

// Gather all buildings from terrain and the mission
private _center = [worldSize / 2, worldSize / 2, 0];
private _buildings = nearestObjects [_center, ["House"], worldSize];
_buildings append (allMissionObjects "building");
_buildings = _buildings arrayIntersect _buildings; // remove duplicates

{
    private _bPos = getPosASL _x;
    private _highestPos = [];
    private _highestZ = -1e9;

    for "_i" from 1 to _raysPerBuilding do {
        // Random point around building center
        private _sample = [_bPos, random _spread, random 360] call BIS_fnc_relPos;
        private _from = AGLToASL (_sample vectorAdd [0,0,200]);
        private _to   = AGLToASL (_sample vectorAdd [0,0,-200]);

        private _hit = lineIntersectsSurfaces [_from, _to, objNull, objNull, true, 1, "GEOM", "NONE"];
        if (_hit isEqualTo []) then { continue; };

        private _surf = (_hit select 0) select 0;
        private _z = _surf select 2;
        if (_z > _highestZ) then {
            _highestZ = _z;
            _highestPos = _surf;
        };
    };

    if (_highestZ > -1e9) then {
        _sniperSpots pushBack _highestPos;
    };
} forEach _buildings;

// Cache results for later use
if (isNil "STALKER_sniperSpots") then { STALKER_sniperSpots = [] };
{ STALKER_sniperSpots pushBackUnique _x } forEach _sniperSpots;

_sniperSpots

