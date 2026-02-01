/*
    Placeholder for emission end handling.
    Triggered when an emission has concluded.
*/

["panic_onEmissionEnd"] call VIC_fnc_debugLog;

// Restore AI behaviour after the emission ends
[] call VIC_fnc_resetAIBehavior;

true
