/*
    Starts the IED management loop. Debug use only.
*/
["startIEDManager"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (missionNamespace getVariable ["VIC_IEDManagerRunning", false]) exitWith {};
missionNamespace setVariable ["VIC_IEDManagerRunning", true];

[] spawn {
    while { missionNamespace getVariable ["VIC_IEDManagerRunning", false] } do {
        [] call VIC_fnc_manageIEDSites;
        sleep 6;
    };
};

true
