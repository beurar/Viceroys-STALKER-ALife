/*
    Spawns flare tripwires in a circular perimeter around a position.
    Params:
        0: POSITION - center position
        1: NUMBER   - radius of the perimeter (default 25)
        2: NUMBER   - number of tripwires (default 6)
    Returns:
        ARRAY - spawned mine objects
*/
params ["_center", ["_radius",25], ["_count",6]];

["spawnFlareTripwires"] call VIC_fnc_debugLog;

if (!isServer) exitWith { [] };

private _objs = [];
private _offset = random 360;
for "_i" from 0 to (_count - 1) do {
    private _dist = _radius - random 3;
    private _angle = _offset + (360 / _count) * _i;
    private _pos = _center getPos [_dist, _angle];
    _pos = [_pos] call VIC_fnc_findLandPos;
    if (isNil {_pos} || {_pos isEqualTo []}) then { continue };

    private _mineType = ["APERSMine", "APERSTripMine"] select (isClass ((configFile >> "CfgVehicles") >> "APERSTripMine"));
    // Use createMine so the Explosion event handler registers correctly
    private _mine = createMine [_mineType, _pos, [], 0];
    _mine setDir ([_pos, _center] call BIS_fnc_dirTo);
    _mine addEventHandler ["Explosion", { "F_40mm_White" createVehicle getPosATL (_this select 0); }];
    _objs pushBack _mine;
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        private _marker = format ["flr_%1", diag_tickTime + _i];
        [_marker, _pos, "ICON", "mil_warning", "#(1,1,0,1)", 0.2, "Flare"] call VIC_fnc_createGlobalMarker;
    };
};
_objs
