/*
    Starts background manager systems for STALKER ALife.
*/


// Starts background manager systems when auto init is enabled.
["initManagers"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

// Only start managers automatically when configured to do so
if !( ["VSA_autoInit", false] call VIC_fnc_getSetting ) exitWith {
    ["initManagers: auto init disabled"] call VIC_fnc_debugLog;
    false
};

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
[] spawn {
    while { true } do {
        [] call VIC_fnc_manageChemicalZones;
        sleep 6;
    };
};
[] spawn {
    while { true } do {
        [] call VIC_fnc_manageHabitats;
        [] call VIC_fnc_manageHerds;
        [] call VIC_fnc_manageHostiles;
        [] call VIC_fnc_manageNests;
        [] call VIC_fnc_managePredators;
        sleep 6;
    };
};
[] spawn {
    sleep 8;
    while { true } do {
        [] call VIC_fnc_updateProximity;
        sleep 6;
    };
};

true
