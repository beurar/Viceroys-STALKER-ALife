/*
    Spawns zombie hordes in a circle around each player from 600m away.

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

    private _angleStep = 360 / _hordes;
    for "_h" from 1 to _hordes do {
        private _angle = (_h - 1) * _angleStep;
        private _pos = _player getPos [600, _angle];
        _pos = [_pos] call VIC_fnc_findLandPosition;
        if (isNil {_pos} || {_pos isEqualTo []}) then { continue };
        if (_mark) then {
            private _markerName = format ["necro_%1", diag_tickTime + random 1000];
            [_markerName, _pos, "ICON", "mil_dot", "#(0.6,0,0,1)", 1, "Necro Spawn"] call VIC_fnc_createGlobalMarker;
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
