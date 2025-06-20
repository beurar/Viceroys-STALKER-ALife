/*
    Starts background manager systems for STALKER ALife.
*/

["initManagers"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

[] call VIC_fnc_startMinefieldManager;
[] call VIC_fnc_startAmbushManager;
[] call VIC_fnc_startSniperManager;
[] call VIC_fnc_startAnomalyManager;
[] spawn {
    while { true } do {
        [] call VIC_fnc_manageWanderers;
        sleep 60;
    };
};
[] spawn {
    while { true } do {
        [] call VIC_fnc_manageWrecks;
        sleep 60;
    };
};
[
    {
        while { true } do {
            [] call VIC_fnc_updateProximity;
            [] call VIC_fnc_updateActivityGrid;
            private _delay = if (["VSA_autoInit", false] call VIC_fnc_getSetting) then {5} else { ["VSA_proximityCheckInterval", 0] call VIC_fnc_getSetting };
            sleep _delay;
        };
    }, [], 8
] call CBA_fnc_waitAndExecute;

true
