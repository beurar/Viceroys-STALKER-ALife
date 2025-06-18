/*
    Spawns tripwire mines in a circular perimeter around a position.
    Params:
        0: POSITION - center position
        1: NUMBER   - radius of the perimeter (default 25)
        2: NUMBER   - number of mines to spawn (default 6)
    Returns:
        ARRAY - spawned mine objects
*/
params ["_center", ["_radius",25], ["_count",6]];

["spawnTripwirePerimeter"] call VIC_fnc_debugLog;

if (!isServer) exitWith { [] };

private _objs = [];

for "_i" from 1 to _count do {
    private _dist = _radius - random 5;
    private _pos = _center getPos [_dist, random 360];
    _pos = [_pos] call VIC_fnc_findLandPosition;
    if (_pos isEqualTo []) then { continue };
    private _mine = createMine ["APERSTripMine_Wire", _pos, [], 0];
    _objs pushBack _mine;

    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        private _marker = format ["tw_%1", diag_tickTime + _i];
        [_marker, _pos, "ICON", "mil_triangle", "ColorOrange", 0.2, "Tripwire"] call VIC_fnc_createGlobalMarker;
    };
};

_objs
