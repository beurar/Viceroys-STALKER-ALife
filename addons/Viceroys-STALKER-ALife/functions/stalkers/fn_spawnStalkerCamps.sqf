/*
    Spawns multiple stalker camps within an area.
    Params:
        0: POSITION - center position
        1: NUMBER   - search radius (default 500)
        2: NUMBER   - camp count (optional)
*/
params [["_center", [worldSize/2, worldSize/2, 0]], ["_radius",500], ["_count",-1]];

["spawnStalkerCamps"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableStalkerCamps", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (_count < 0) then { _count = ["VSA_stalkerCampCount",1] call VIC_fnc_getSetting; };

private _clusters = [] call VIC_fnc_findBuildingClusters;
if (_clusters isEqualTo []) exitWith {};

for "_i" from 1 to _count do {
    private _campPos = [];
    private _attempts = 0;
    while {_campPos isEqualTo [] && {_attempts < 20}} do {
        private _cluster = selectRandom _clusters;
        private _centerPos = [0,0,0];
        { _centerPos = _centerPos vectorAdd getPosATL _x } forEach _cluster;
        _centerPos = _centerPos vectorMultiply (1 / (count _cluster));
        if (_center distance2D _centerPos <= _radius) then {
            _campPos = [_centerPos, 30, 10, true] call VIC_fnc_findLandPosition;
        };
        _attempts = _attempts + 1;
    };
    if (isNil {_campPos} || {_campPos isEqualTo []}) then { continue };
    [_campPos] call VIC_fnc_spawnStalkerCamp;
};
