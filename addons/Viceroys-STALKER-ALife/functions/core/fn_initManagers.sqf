/*
    Starts background manager systems for STALKER ALife.
*/

["initManagers"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

[] call VIC_fnc_startMinefieldManager;
[] call VIC_fnc_startIEDManager;
[] call VIC_fnc_startAmbushManager;
[] call VIC_fnc_startSniperManager;
[] call VIC_fnc_startCampManager;
[] call VIC_fnc_startAnomalyManager;
[] spawn {
    while { true } do {
        [] call VIC_fnc_manageWanderers;
        [] call VIC_fnc_manageSpookZones;
        sleep 6;
    };
};
[] spawn {
    while { true } do {
        [] call VIC_fnc_manageWrecks;
        sleep 6;
    };
};
[
    {
        while { true } do {
            [] call VIC_fnc_updateProximity;
            sleep 6;
        };
    }, [], 8
] call CBA_fnc_waitAndExecute;

true
