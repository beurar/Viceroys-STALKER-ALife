// Spawn zombies from the tracked corpse queue once the emission ends

["spawnZombiesFromQueue"] call VIC_fnc_debugLog;

if (["VSA_enableZombification", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

// read and clear the queue
private _queue = missionNamespace getVariable ["ALF_zombieQueue", []];
missionNamespace setVariable ["ALF_zombieQueue", []];

// list of WebKnight zombie classes
private _zClasses = [
    "WBK_Zombie1",
    "WBK_Zombie2",
    "WBK_Zombie3"
];

{
    private _corpse = _x;
    if (!isNull _corpse) then {
        private _pos = getPosATL _corpse;
        private _dir = getDir _corpse;
        deleteVehicle _corpse;

        private _class = selectRandom _zClasses;
        private _zombie = createAgent [_class, _pos, [], 0, "NONE"];
        _zombie setDir _dir;
        [_zombie] call VIC_fnc_initMutantUnit;
    };
} forEach _queue;

