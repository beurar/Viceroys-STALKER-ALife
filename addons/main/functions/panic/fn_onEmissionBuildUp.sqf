/*
    Placeholder for emission buildup handling.
    Triggered when an emission begins to build up.
*/

["panic_onEmissionBuildUp"] call VIC_fnc_debugLog;

// Trigger panic behaviour on nearby AI
[] call VIC_fnc_triggerAIPanic;

true
