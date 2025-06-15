/*
    Spawns zombie hordes around each player from hidden positions.

    Params:
        0: NUMBER - zombies per horde (default 5)
        1: NUMBER - horde count per player (default 2)
        2: BOOL   - mark spawn positions when true (default false)
*/
params [["_zombies",5],["_hordes",2],["_mark",false]];

["triggerNecroplague"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (["VSA_enableNecroplague", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

private _classes = ["WBK_Zombie1","WBK_Zombie2","WBK_Zombie3"];

{
    private _player = _x;
    if (isNull _player || {!alive _player}) then { continue };

    for "_h" from 1 to _hordes do {
        private _pos = [_player,50,5] call VIC_fnc_findBuildingCoverSpot;
        if (isNil "_pos") then { _pos = [_player,100,5] call VIC_fnc_findBuildingCoverSpot; };
        if (isNil "_pos") then {
            private _angle = random 360;
            private _dist = 40 + random 40;
            _pos = _player getPos [_dist, _angle];
        };
        _pos = [_pos] call VIC_fnc_findLandPosition;
        if (_pos isEqualTo []) then { continue };
        if (_mark) then {
            private _markerName = format ["necro_%1", diag_tickTime + random 1000];
            [_markerName, _pos, "ICON", "mil_dot", "ColorRed", 1, "Necro Spawn"] call VIC_fnc_createGlobalMarker;
        };
        private _grp = createGroup east;
        for "_i" from 1 to _zombies do {
            private _unit = _grp createUnit [selectRandom _classes, _pos, [], 0, "FORM"];
            [_unit] call VIC_fnc_initMutantUnit;
        };
        [_grp, _player] call BIS_fnc_taskAttack;
    };
} forEach allPlayers;

true
