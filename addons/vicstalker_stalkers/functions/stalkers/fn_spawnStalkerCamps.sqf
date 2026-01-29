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

for "_i" from 1 to _count do {
    private _building = [] call VIC_fnc_findCampBuilding;
    if (isNull _building) exitWith {};
    private _campPos = getPosATL _building;
    [_campPos] call VIC_fnc_spawnStalkerCamp;
};
