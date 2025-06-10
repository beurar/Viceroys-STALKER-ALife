/*
    Master initialization for STALKER ALife.
    This sets up CBA settings, registers every function as a CBA XEH
    handler and kicks off emission related hooks.
*/

// --- CBA Settings -----------------------------------------------------------
["preInit", {
    if (fileExists "cba_settings.sqf") then {
        call compile preprocessFileLineNumbers "cba_settings.sqf";
    };
}] call CBA_fnc_addEventHandler;

if (!isServer) exitWith {};

["masterInit"] call VIC_fnc_debugLog;

// --- Function Registration -------------------------------------------------
["preInit", {
    VIC_fnc_resetAIBehavior         = compile preprocessFileLineNumbers "functions/ai/fn_resetAIBehavior.sqf";
    VIC_fnc_triggerAIPanic          = compile preprocessFileLineNumbers "functions/ai/fn_triggerAIPanic.sqf";
    VIC_fnc_cleanupRadiationZones   = compile preprocessFileLineNumbers "functions/radiation/fn_cleanupRadiationZones.sqf";
    VIC_fnc_spawnRadiationZone      = compile preprocessFileLineNumbers "functions/radiation/fn_spawnRadiationZone.sqf";
    VIC_fnc_spawnRandomRadiationZones = compile preprocessFileLineNumbers "functions/radiation/fn_spawnRandomRadiationZones.sqf";
    VIC_fnc_spawnZombiesFromQueue   = compile preprocessFileLineNumbers "functions/zombification/fn_spawnZombiesFromQueue.sqf";
    VIC_fnc_trackDeadForZombify     = compile preprocessFileLineNumbers "functions/zombification/fn_trackDeadForZombify.sqf";
    VIC_fnc_spawnAllAnomalyFields   = compile preprocessFileLineNumbers "functions/anomalies/fn_spawnAllAnomalyFields.sqf";
    VIC_fnc_findSite_electra        = compile preprocessFileLineNumbers "functions/anomalies/find_sites/fn_findSite_electra.sqf";
    VIC_fnc_findSite_springboard    = compile preprocessFileLineNumbers "functions/anomalies/find_sites/fn_findSite_springboard.sqf";
    VIC_fnc_findSite_meatgrinder    = compile preprocessFileLineNumbers "functions/anomalies/find_sites/fn_findSite_meatgrinder.sqf";
    VIC_fnc_findSite_burner         = compile preprocessFileLineNumbers "functions/anomalies/find_sites/fn_findSite_burner.sqf";
    VIC_fnc_findSite_clicker        = compile preprocessFileLineNumbers "functions/anomalies/find_sites/fn_findSite_clicker.sqf";
    VIC_fnc_findSite_fruitpunch     = compile preprocessFileLineNumbers "functions/anomalies/find_sites/fn_findSite_fruitpunch.sqf";
    VIC_fnc_findSite_whirligig      = compile preprocessFileLineNumbers "functions/anomalies/find_sites/fn_findSite_whirligig.sqf";
    VIC_fnc_findSite_gravi          = compile preprocessFileLineNumbers "functions/anomalies/find_sites/fn_findSite_gravi.sqf";
    VIC_fnc_createField_gravi       = compile preprocessFileLineNumbers "functions/anomalies/fields/fn_createField_gravi.sqf";
    VIC_fnc_createField_burner      = compile preprocessFileLineNumbers "functions/anomalies/fields/fn_createField_burner.sqf";
    VIC_fnc_createField_electra     = compile preprocessFileLineNumbers "functions/anomalies/fields/fn_createField_electra.sqf";
    VIC_fnc_createField_fruitpunch  = compile preprocessFileLineNumbers "functions/anomalies/fields/fn_createField_fruitpunch.sqf";
    VIC_fnc_createField_springboard = compile preprocessFileLineNumbers "functions/anomalies/fields/fn_createField_springboard.sqf";
    VIC_fnc_createField_meatgrinder = compile preprocessFileLineNumbers "functions/anomalies/fields/fn_createField_meatgrinder.sqf";
    VIC_fnc_createField_whirligig   = compile preprocessFileLineNumbers "functions/anomalies/fields/fn_createField_whirligig.sqf";
    VIC_fnc_createField_clicker     = compile preprocessFileLineNumbers "functions/anomalies/fields/fn_createField_clicker.sqf";
    VIC_fnc_schedulePsyStorms       = compile preprocessFileLineNumbers "functions/storms/fn_schedulePsyStorms.sqf";
    VIC_fnc_triggerPsyStorm         = compile preprocessFileLineNumbers "functions/storms/fn_triggerPsyStorm.sqf";
    VIC_fnc_setupSpookZones         = compile preprocessFileLineNumbers "functions/spooks/fn_setupSpookZones.sqf";
    VIC_fnc_spawnSpookZone          = compile preprocessFileLineNumbers "functions/spooks/fn_spawnSpookZone.sqf";
    VIC_fnc_spawnMutantGroup        = compile preprocessFileLineNumbers "functions/mutants/fn_spawnMutantGroup.sqf";
    VIC_fnc_spawnAmbientHerds       = compile preprocessFileLineNumbers "functions/mutants/fn_spawnAmbientHerds.sqf";
    VIC_fnc_registerEmissionHooks   = compile preprocessFileLineNumbers "functions/core/fn_registerEmissionHooks.sqf";
    VIC_fnc_debugLog                = compile preprocessFileLineNumbers "functions/core/fn_debugLog.sqf";
    VIC_fnc_setupDebugActions       = compile preprocessFileLineNumbers "functions/core/fn_setupDebugActions.sqf";
}] call CBA_fnc_addEventHandler;

// --- PostInit ---------------------------------------------------------------
["postInit", {
    [] call VIC_fnc_registerEmissionHooks;
    if (["VSA_debugMode", false] call CBA_fnc_getSetting) then {
        [] call VIC_fnc_setupDebugActions;
    };
}] call CBA_fnc_addEventHandler;

