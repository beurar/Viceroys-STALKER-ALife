/*
    Starts the anomaly field management loop. Debug use only.
*/
["startAnomalyManager"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (missionNamespace getVariable ["VIC_anomalyManagerRunning", false]) exitWith {};
missionNamespace setVariable ["VIC_anomalyManagerRunning", true];

[] spawn {
    while { missionNamespace getVariable ["VIC_anomalyManagerRunning", false] } do {
        [] call VIC_fnc_manageAnomalyFields;
        sleep 6;
    };
};

true
