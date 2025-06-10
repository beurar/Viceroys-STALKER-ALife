/*
    Master initialization for STALKER ALife.
    This sets up CBA settings, registers every function as a CBA XEH
    handler and kicks off emission related hooks.
*/

// --- CBA Settings -----------------------------------------------------------
if (fileExists "\Viceroys-STALKER-ALife\cba_settings.sqf") then {
    call compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\cba_settings.sqf";
};

if (!isServer) exitWith {};

["masterInit"] call VIC_fnc_debugLog;

// --- Function Registration -------------------------------------------------
VIC_fnc_resetAIBehavior          = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\ai\fn_resetAIBehavior.sqf";
VIC_fnc_triggerAIPanic           = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\ai\fn_triggerAIPanic.sqf";
VIC_fnc_cleanupRadiationZones    = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\radiation\fn_cleanupRadiationZones.sqf";
VIC_fnc_spawnRadiationZone       = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\radiation\fn_spawnRadiationZone.sqf";
VIC_fnc_spawnRandomRadiationZones = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\radiation\fn_spawnRandomRadiationZones.sqf";
VIC_fnc_spawnZombiesFromQueue    = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\zombification\fn_spawnZombiesFromQueue.sqf";
VIC_fnc_trackDeadForZombify      = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\zombification\fn_trackDeadForZombify.sqf";
VIC_fnc_spawnAllAnomalyFields    = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fn_spawnAllAnomalyFields.sqf";
VIC_fnc_cleanupAnomalyMarkers    = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fn_cleanupAnomalyMarkers.sqf";
VIC_fnc_findSite_electra         = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\find_sites\fn_findSite_electra.sqf";
VIC_fnc_findSite_springboard     = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\find_sites\fn_findSite_springboard.sqf";
VIC_fnc_findSite_meatgrinder     = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\find_sites\fn_findSite_meatgrinder.sqf";
VIC_fnc_findSite_burner          = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\find_sites\fn_findSite_burner.sqf";
VIC_fnc_findSite_clicker         = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\find_sites\fn_findSite_clicker.sqf";
VIC_fnc_findSite_fruitpunch      = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\find_sites\fn_findSite_fruitpunch.sqf";
VIC_fnc_findSite_whirligig       = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\find_sites\fn_findSite_whirligig.sqf";
VIC_fnc_findSite_gravi           = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\find_sites\fn_findSite_gravi.sqf";
VIC_fnc_createField_gravi        = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fields\fn_createField_gravi.sqf";
VIC_fnc_createField_burner       = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fields\fn_createField_burner.sqf";
VIC_fnc_createField_electra      = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fields\fn_createField_electra.sqf";
VIC_fnc_createField_fruitpunch   = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fields\fn_createField_fruitpunch.sqf";
VIC_fnc_createField_springboard  = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fields\fn_createField_springboard.sqf";
VIC_fnc_createField_meatgrinder  = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fields\fn_createField_meatgrinder.sqf";
VIC_fnc_createField_whirligig    = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fields\fn_createField_whirligig.sqf";
VIC_fnc_createField_clicker      = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fields\fn_createField_clicker.sqf";
VIC_fnc_schedulePsyStorms        = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\storms\fn_schedulePsyStorms.sqf";
VIC_fnc_triggerPsyStorm          = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\storms\fn_triggerPsyStorm.sqf";
VIC_fnc_setupSpookZones          = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\spooks\fn_setupSpookZones.sqf";
VIC_fnc_spawnSpookZone           = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\spooks\fn_spawnSpookZone.sqf";
VIC_fnc_spawnMutantGroup         = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\mutants\fn_spawnMutantGroup.sqf";
VIC_fnc_spawnAmbientHerds        = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\mutants\fn_spawnAmbientHerds.sqf";
VIC_fnc_setupMutantHabitats      = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\mutants\fn_setupMutantHabitats.sqf";
panic_fnc_onEmissionBuildUp  = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\panic\fn_onEmissionBuildUp.sqf";
panic_fnc_onEmissionStart    = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\panic\fn_onEmissionStart.sqf";
panic_fnc_onEmissionEnd      = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\panic\fn_onEmissionEnd.sqf";
anomalies_fnc_onEmissionBuildUp = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fn_onEmissionBuildUp.sqf";
anomalies_fnc_onEmissionStart   = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fn_onEmissionStart.sqf";
anomalies_fnc_onEmissionEnd     = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\anomalies\fn_onEmissionEnd.sqf";
mutants_fnc_onEmissionStart  = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\mutants\fn_onEmissionStart.sqf";
mutants_fnc_onEmissionEnd    = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\mutants\fn_onEmissionEnd.sqf";
radiation_fnc_onEmissionStart = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\radiation\fn_onEmissionStart.sqf";
radiation_fnc_onEmissionEnd   = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\radiation\fn_onEmissionEnd.sqf";
zombification_fnc_onEmissionEnd = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\zombification\fn_onEmissionEnd.sqf";
VIC_fnc_hasPlayersNearby         = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\core\fn_hasPlayersNearby.sqf";
VIC_fnc_registerEmissionHooks    = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\core\fn_registerEmissionHooks.sqf";
VIC_fnc_debugLog                 = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\core\fn_debugLog.sqf";
VIC_fnc_setupDebugActions        = compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\core\fn_setupDebugActions.sqf";

// --- PostInit ---------------------------------------------------------------
["postInit", {
    [] call VIC_fnc_registerEmissionHooks;
    [] call VIC_fnc_schedulePsyStorms;
    [] call VIC_fnc_setupMutantHabitats;
    if (["VSA_debugMode", false] call CBA_fnc_getSetting) then {
        [] call VIC_fnc_setupDebugActions;
    };
}] call CBA_fnc_addEventHandler;

// Track units killed during emissions for later zombification
["EntityKilled", {
    params ["_unit"];
    [_unit] call VIC_fnc_trackDeadForZombify;
}] call CBA_fnc_addEventHandler;

