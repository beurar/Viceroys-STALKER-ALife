/*
    Register hooks for blowout events from Diwako's Anomalies.  The
    `blowOutStage` event indicates the current stage of the blowout.
    Stage `1` is the build-up phase, stage `2` marks the start of the
    wave and stage `0` signals the end.  Each handler updates the
    `emission_active` flag and forwards the notification to the
    appropriate subsystem handler.
*/

// ensure the flag exists
missionNamespace setVariable ["emission_active", false];

["registerEmissionHooks"] call VIC_fnc_debugLog;

["diwako_anomalies_main_blowOutStage", {
    params ["_stage"];
    switch (_stage) do {
        case 1: {
            missionNamespace setVariable ["emission_active", true];
            [] call panic_fnc_onEmissionBuildUp;
            [] call anomalies_fnc_onEmissionBuildUp;
        };
        case 2: {
            missionNamespace setVariable ["emission_active", true];
            [] call panic_fnc_onEmissionStart;
            [] call anomalies_fnc_onEmissionStart;
            [] call mutants_fnc_onEmissionStart;
            [] call chemical_fnc_onEmissionStart;
        };
        case 0: {
            missionNamespace setVariable ["emission_active", false];
            [] call panic_fnc_onEmissionEnd;
            [] call anomalies_fnc_onEmissionEnd;
            [] call mutants_fnc_onEmissionEnd;
            [] call chemical_fnc_onEmissionEnd;
            [] call zombification_fnc_onEmissionEnd;

            [true] call VIC_fnc_cleanupChemicalZones;

            private _radius = ["VSA_emissionChemicalRadius", 300] call VIC_fnc_getSetting;
            private _count  = ["VSA_emissionChemicalCount", 2] call VIC_fnc_getSetting;
            {
                [_x, _radius, _count, -1] call VIC_fnc_spawnRandomChemicalZones;
            } forEach allPlayers;
        };
        default {};
    };
}] call CBA_fnc_addEventHandler;

