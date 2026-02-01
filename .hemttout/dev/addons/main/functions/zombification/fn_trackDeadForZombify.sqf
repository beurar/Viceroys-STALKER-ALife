// Collect units that die during an emission so they can be turned into zombies

["trackDeadForZombify"] call VIC_fnc_debugLog;

params ["_unit"];

// respect CBA settings
if (["VSA_enableZombification", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};
if (["VSA_zombiesNightOnly", false] call VIC_fnc_getSetting && {dayTime > 5 && dayTime < 20}) exitWith {};

// only track during an active emission
if !(missionNamespace getVariable ["emission_active", false]) exitWith {};

// ensure queue exists
private _queue = missionNamespace getVariable ["ALF_zombieQueue", []];

if (!isNull _unit) then {
    if (count _queue < (["VSA_zombieCount", 15] call VIC_fnc_getSetting)) then {
        if (random 100 < (["VSA_zombieSpawnWeight", 50] call VIC_fnc_getSetting)) then {
            _queue pushBack _unit;
        };
    };
};

missionNamespace setVariable ["ALF_zombieQueue", _queue];

