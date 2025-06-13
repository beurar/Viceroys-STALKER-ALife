/*
    Spawns multiple stalker camps within an area.
    Params:
        0: POSITION - center position
        1: NUMBER   - search radius (default 500)
        2: NUMBER   - camp count (optional)
*/
params ["_center", ["_radius",500], ["_count",-1]];

["spawnStalkerCamps"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableStalkerCamps", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (_count < 0) then { _count = ["VSA_stalkerCampCount",1] call VIC_fnc_getSetting; };

for "_i" from 1 to _count do {
    private _pos = _center getPos [random _radius, random 360];
    _pos = [_pos] call VIC_fnc_findLandPosition;
    if (_pos isEqualTo []) then { continue };
    [_pos] call VIC_fnc_spawnStalkerCamp;
};
