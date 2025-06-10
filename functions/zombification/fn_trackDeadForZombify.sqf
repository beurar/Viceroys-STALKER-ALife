// Collect units that die during an emission so they can be turned into zombies

params ["_unit"];

// only track during an active emission
if !(missionNamespace getVariable ["ALF_emissionActive", false]) exitWith {};

// ensure queue exists
private _queue = missionNamespace getVariable ["ALF_zombieQueue", []];

if (!isNull _unit) then {
    _queue pushBack _unit;
};

missionNamespace setVariable ["ALF_zombieQueue", _queue];

