/*
    Register hooks for TTS emission events.  The events we care about are
    `buildUp`, `start` and `end`.  Each phase informs the various game
    subsystems that an emission is in progress so they can react
    accordingly.

    This script relies on the CBA event system which is used by the TTS
    emission module.  Each handler simply sets the `emission_active` flag
    and then forwards the notification to the appropriate subsystem
    handler.
*/

// ensure the flag exists
missionNamespace setVariable ["emission_active", false];

["registerEmissionHooks"] call VIC_fnc_debugLog;

// --- build up phase -------------------------------------------------------
[
    "TTS_emission_buildUp",
    {
        missionNamespace setVariable ["emission_active", true];

        // Notify subsystems
        [] call panic_fnc_onEmissionBuildUp;
        [] call anomalies_fnc_onEmissionBuildUp;
    }
] call CBA_fnc_addEventHandler;

// --- start phase ---------------------------------------------------------
[
    "TTS_emission_start",
    {
        missionNamespace setVariable ["emission_active", true];

        // Notify subsystems
        [] call panic_fnc_onEmissionStart;
        [] call anomalies_fnc_onEmissionStart;
        [] call mutants_fnc_onEmissionStart;
        [] call chemical_fnc_onEmissionStart;
    }
] call CBA_fnc_addEventHandler;

// --- end phase -----------------------------------------------------------
[
    "TTS_emission_end",
    {
        missionNamespace setVariable ["emission_active", false];

        // Notify subsystems
        [] call panic_fnc_onEmissionEnd;
        [] call anomalies_fnc_onEmissionEnd;
        [] call mutants_fnc_onEmissionEnd;
        [] call chemical_fnc_onEmissionEnd;
        [] call zombification_fnc_onEmissionEnd;

        // remove old chemical zones and spawn new ones
        [true] call VIC_fnc_cleanupChemicalZones;

        private _radius = ["VSA_emissionChemicalRadius", 300] call CBA_fnc_getSetting;
        private _count  = ["VSA_emissionChemicalCount", 2] call CBA_fnc_getSetting;
        {
            [_x, _radius, _count, -1] call VIC_fnc_spawnRandomChemicalZones;
        } forEach allPlayers;
    }
] call CBA_fnc_addEventHandler;

