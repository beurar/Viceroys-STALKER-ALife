/*
    Starts background manager systems for STALKER ALife.
*/

["initManagers"] call VIC_fnc_debugLog;

if (!isServer) exitWith { false };

[] call VIC_fnc_startMinefieldManager;
[] call VIC_fnc_startAmbushManager;
[
    {
        while { true } do {
            [] call VIC_fnc_updateProximity;
            private _delay = ["VSA_proximityCheckInterval", 0] call VIC_fnc_getSetting;
            sleep _delay;
        };
    }, [], 8
] call CBA_fnc_waitAndExecute;

true
