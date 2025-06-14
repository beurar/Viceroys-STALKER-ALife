/*
    Completes the chemical sampling mission and pays the reward.
    Params:
        0: NUMBER - reward amount (optional)
*/
params [["_reward",-1]];

if (!isServer) exitWith {};

if (_reward < 0) then { _reward = missionNamespace getVariable ["STALKER_chemSample_data", [0,0,0,0]] select 3; };
if (!isNil "A3U_fnc_addMoney") then { [_reward] call A3U_fnc_addMoney; };

missionNamespace setVariable ["STALKER_chemSample_active", false];
missionNamespace setVariable ["STALKER_chemSample_data", nil];
