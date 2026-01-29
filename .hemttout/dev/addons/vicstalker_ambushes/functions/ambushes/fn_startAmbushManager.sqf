/*
    Starts the ambush management loop. Debug use only.
*/
["startAmbushManager"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (missionNamespace getVariable ["VIC_ambushManagerRunning", false]) exitWith {};
missionNamespace setVariable ["VIC_ambushManagerRunning", true];

[] spawn {
    while { missionNamespace getVariable ["VIC_ambushManagerRunning", false] } do {
        [] call VIC_fnc_manageAmbushes;
        sleep 6;
    };
};

true
