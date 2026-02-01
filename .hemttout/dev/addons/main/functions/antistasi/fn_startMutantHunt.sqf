/*
    Starts a timed mutant hunting mission that awards money per kill.

    Params:
        0: NUMBER - duration in seconds (default 600)
        1: NUMBER - cash reward per kill (default 50)

    Returns:
        BOOL - true when the mission starts
*/
params [["_duration",600],["_reward",50]];

if !(call VIC_fnc_isAntistasiUltimate) exitWith {false};
if (!isServer) exitWith {false};

missionNamespace setVariable ["STALKER_mutantHunt", [0,_reward,diag_tickTime + _duration]];
missionNamespace setVariable ["STALKER_mutantHunt_active", true];

[{
    missionNamespace setVariable ["STALKER_mutantHunt_active", false];
}, [], _duration] call CBA_fnc_waitAndExecute;

if (!isNil "A3U_fnc_createTask") then {
    ["VIC_MutantHunt","Mutant Hunt","Eliminate mutants for cash.",objNull] call A3U_fnc_createTask;
};

true
