/*
    Starts the sniper management loop. Debug use only.
*/
["startSniperManager"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (missionNamespace getVariable ["VIC_sniperManagerRunning", false]) exitWith {};
missionNamespace setVariable ["VIC_sniperManagerRunning", true];

[] spawn {
    while { missionNamespace getVariable ["VIC_sniperManagerRunning", false] } do {
        [] call VIC_fnc_manageSnipers;
        sleep 6;
    };
};

true
