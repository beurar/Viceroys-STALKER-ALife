/*
    Spawns tripwire mines in a circular perimeter around a position.
    Params:
        0: POSITION - center position
        1: NUMBER   - radius of the perimeter (default 25)
        2: NUMBER   - number of mines to spawn (default 6)
        3: NUMBER   - desired spacing between mines (optional)
    Returns:
        ARRAY - spawned mine objects
*/
params ["_center", ["_radius",25], ["_count",6], ["_spacing",-1]];

if (_spacing > 0) then {
    _count = floor ((2 * pi * _radius) / _spacing);
    if (_count < 1) then { _count = 1 }; 
};

["spawnTripwirePerimeter"] call VIC_fnc_debugLog;

if (!isServer) exitWith { [] };

private _objs = [];
private _positions = [];
private _offset = random 360;

// determine mine positions first
for "_i" from 0 to (_count - 1) do {
    private _dist = _radius - random 5;
    private _angle = _offset + (360 / _count) * _i;
    private _pos = _center getPos [_dist, _angle];
    _pos = [_pos] call VIC_fnc_findLandPos;
    if (isNil {_pos} || {_pos isEqualTo []}) then { continue };
    _positions pushBack _pos;
};

// spawn mines and orient them toward the next mine to form a perimeter
for "_i" from 0 to ((count _positions) - 1) do {
    private _pos = _positions select _i;
    private _nextPos = _positions select ((_i + 1) mod (count _positions));

    // Spawn tripwire mine vehicles with a fallback APERS mine
    private _mineType = ["APERSMine", "APERSTripMine"] select (isClass ((configFile >> "CfgVehicles") >> "APERSTripMine"));
    private _mine = createVehicle [_mineType, _pos, [], 0, "CAN_COLLIDE"];
    _mine setDir ([_pos, _nextPos] call BIS_fnc_dirTo);
    _objs pushBack _mine;

    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        private _marker = format ["tw_%1", diag_tickTime + _i];
        [_marker, _pos, "ICON", "mil_triangle", "#(1,0.5,0,1)", 0.2, "Tripwire"] call VIC_fnc_createGlobalMarker;
    };
};

_objs
