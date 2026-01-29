/*
    Completes the active artefact hunt and pays the reward.
*/

if (!isServer) exitWith {};

private _reward = missionNamespace getVariable ["STALKER_artifactReward",0];
if (!isNil "A3U_fnc_addMoney") then { [_reward] call A3U_fnc_addMoney; };

missionNamespace setVariable ["STALKER_artifactReward", nil];
missionNamespace setVariable ["STALKER_artifactTarget", objNull];
