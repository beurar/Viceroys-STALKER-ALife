/*
    Master initialization for STALKER ALife.
    This sets up CBA settings, registers every function as a CBA XEH
    handler and kicks off emission related hooks.
*/

// --- CBA Settings -----------------------------------------------------------
private _root = "\Viceroys-STALKER-ALife";
private _settings = _root + "\cba_settings.sqf";
if (fileExists _settings) then {
    waitUntil {!isNil "CBA_fnc_addSetting"};
    call compile preprocessFileLineNumbers _settings;
};


["masterInit"] call VIC_fnc_debugLog;
if (isServer) then {

// --- Function Registration -------------------------------------------------
VIC_fnc_resetAIBehavior          = compile preprocessFileLineNumbers (_root + "\functions\ai\fn_resetAIBehavior.sqf");
VIC_fnc_triggerAIPanic           = compile preprocessFileLineNumbers (_root + "\functions\ai\fn_triggerAIPanic.sqf");
VIC_fnc_cleanupChemicalZones    = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_cleanupChemicalZones.sqf");
VIC_fnc_spawnChemicalZone       = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_spawnChemicalZone.sqf");
VIC_fnc_spawnRandomChemicalZones = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_spawnRandomChemicalZones.sqf");
VIC_fnc_spawnZombiesFromQueue    = compile preprocessFileLineNumbers (_root + "\functions\zombification\fn_spawnZombiesFromQueue.sqf");
VIC_fnc_trackDeadForZombify      = compile preprocessFileLineNumbers (_root + "\functions\zombification\fn_trackDeadForZombify.sqf");
VIC_fnc_spawnAllAnomalyFields    = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_spawnAllAnomalyFields.sqf");
VIC_fnc_cleanupAnomalyMarkers    = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_cleanupAnomalyMarkers.sqf");
VIC_fnc_findSite_electra         = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_electra.sqf");
VIC_fnc_findSite_springboard     = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_springboard.sqf");
VIC_fnc_findSite_meatgrinder     = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_meatgrinder.sqf");
VIC_fnc_findSite_burner          = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_burner.sqf");
VIC_fnc_findSite_clicker         = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_clicker.sqf");
VIC_fnc_findSite_fruitpunch      = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_fruitpunch.sqf");
VIC_fnc_findSite_whirligig       = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_whirligig.sqf");
VIC_fnc_findSite_gravi           = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_gravi.sqf");
VIC_fnc_findSite_launchpad      = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_launchpad.sqf");
VIC_fnc_findSite_leech          = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_leech.sqf");
VIC_fnc_findSite_trapdoor       = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_trapdoor.sqf");
VIC_fnc_findSite_zapper         = compile preprocessFileLineNumbers (_root + "\functions\anomalies\find_sites\fn_findSite_zapper.sqf");
VIC_fnc_createField_gravi        = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_gravi.sqf");
VIC_fnc_createField_burner       = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_burner.sqf");
VIC_fnc_createField_electra      = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_electra.sqf");
VIC_fnc_createField_fruitpunch   = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_fruitpunch.sqf");
VIC_fnc_createField_springboard  = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_springboard.sqf");
VIC_fnc_createField_meatgrinder  = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_meatgrinder.sqf");
VIC_fnc_createField_whirligig    = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_whirligig.sqf");
VIC_fnc_createField_clicker      = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_clicker.sqf");
VIC_fnc_createField_launchpad   = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_launchpad.sqf");
VIC_fnc_createField_leech       = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_leech.sqf");
VIC_fnc_createField_trapdoor    = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_trapdoor.sqf");
VIC_fnc_createField_zapper      = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_zapper.sqf");
VIC_fnc_schedulePsyStorms        = compile preprocessFileLineNumbers (_root + "\functions\storms\fn_schedulePsyStorms.sqf");
VIC_fnc_triggerPsyStorm          = compile preprocessFileLineNumbers (_root + "\functions\storms\fn_triggerPsyStorm.sqf");
VIC_fnc_setupSpookZones          = compile preprocessFileLineNumbers (_root + "\functions\spooks\fn_setupSpookZones.sqf");
VIC_fnc_spawnSpookZone           = compile preprocessFileLineNumbers (_root + "\functions\spooks\fn_spawnSpookZone.sqf");
VIC_fnc_spawnMutantGroup         = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnMutantGroup.sqf");
VIC_fnc_spawnAmbientHerds        = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnAmbientHerds.sqf");
VIC_fnc_setupMutantHabitats      = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_setupMutantHabitats.sqf");
VIC_fnc_spawnMutantNest         = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnMutantNest.sqf");
VIC_fnc_spawnBloodsuckerNest     = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnBloodsuckerNest.sqf");
VIC_fnc_spawnBoarNest           = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnBoarNest.sqf");
VIC_fnc_spawnCatNest            = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnCatNest.sqf");
VIC_fnc_spawnFleshNest          = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnFleshNest.sqf");
VIC_fnc_spawnBlindDogNest       = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnBlindDogNest.sqf");
VIC_fnc_spawnPseudodogNest      = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnPseudodogNest.sqf");
VIC_fnc_spawnControllerNest     = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnControllerNest.sqf");
VIC_fnc_spawnPseudogiantNest    = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnPseudogiantNest.sqf");
VIC_fnc_spawnIzlomNest          = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnIzlomNest.sqf");
VIC_fnc_spawnCorruptorNest      = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnCorruptorNest.sqf");
VIC_fnc_spawnSmasherNest        = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnSmasherNest.sqf");
VIC_fnc_spawnAcidSmasherNest    = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnAcidSmasherNest.sqf");
VIC_fnc_spawnBehemothNest       = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnBehemothNest.sqf");
VIC_fnc_manageHerds              = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageHerds.sqf");
VIC_fnc_manageHostiles           = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageHostiles.sqf");
VIC_fnc_manageNests              = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageNests.sqf");
panic_fnc_onEmissionBuildUp  = compile preprocessFileLineNumbers (_root + "\functions\panic\fn_onEmissionBuildUp.sqf");
panic_fnc_onEmissionStart    = compile preprocessFileLineNumbers (_root + "\functions\panic\fn_onEmissionStart.sqf");
panic_fnc_onEmissionEnd      = compile preprocessFileLineNumbers (_root + "\functions\panic\fn_onEmissionEnd.sqf");
anomalies_fnc_onEmissionBuildUp = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_onEmissionBuildUp.sqf");
anomalies_fnc_onEmissionStart   = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_onEmissionStart.sqf");
anomalies_fnc_onEmissionEnd     = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_onEmissionEnd.sqf");
mutants_fnc_onEmissionStart  = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_onEmissionStart.sqf");
mutants_fnc_onEmissionEnd    = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_onEmissionEnd.sqf");
chemical_fnc_onEmissionStart = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_onEmissionStart.sqf");
chemical_fnc_onEmissionEnd   = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_onEmissionEnd.sqf");
zombification_fnc_onEmissionEnd = compile preprocessFileLineNumbers (_root + "\functions\zombification\fn_onEmissionEnd.sqf");
VIC_fnc_hasPlayersNearby         = compile preprocessFileLineNumbers (_root + "\functions\core\fn_hasPlayersNearby.sqf");
VIC_fnc_registerEmissionHooks    = compile preprocessFileLineNumbers (_root + "\functions\core\fn_registerEmissionHooks.sqf");
VIC_fnc_getSetting               = compile preprocessFileLineNumbers (_root + "\functions\core\fn_getSetting.sqf");
VIC_fnc_debugLog                 = compile preprocessFileLineNumbers (_root + "\functions\core\fn_debugLog.sqf");
VIC_fnc_setupDebugActions        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_setupDebugActions.sqf");
VIC_fnc_markAllBuildings        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markAllBuildings.sqf");

// --- PostInit ---------------------------------------------------------------
["postInit", {
    [] call VIC_fnc_registerEmissionHooks;
    [] call VIC_fnc_schedulePsyStorms;
    [] call VIC_fnc_setupMutantHabitats;
    [
        {
            while {true} do {
                [] call VIC_fnc_manageHerds;
                sleep 60;
            };
        }, [], 10
    ] call CBA_fnc_waitAndExecute;

    [
        {
            while {true} do {
                [] call VIC_fnc_manageHostiles;
                sleep 60;
            };
        }, [], 15
    ] call CBA_fnc_waitAndExecute;

    [
        {
            while {true} do {
                [] call VIC_fnc_manageNests;
                sleep 300;
            };
        }, [], 20
    ] call CBA_fnc_waitAndExecute;
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        [] call VIC_fnc_setupDebugActions;
        [] call VIC_fnc_markAllBuildings;
    };
}] call CBA_fnc_addEventHandler;

// Track units killed during emissions for later zombification
["EntityKilled", {
    params ["_unit"];
    [_unit] call VIC_fnc_trackDeadForZombify;
  }] call CBA_fnc_addEventHandler;
} else {
    ["postInit", {
        if (hasInterface && ["VSA_debugMode", false] call VIC_fnc_getSetting) then {
            [] call VIC_fnc_setupDebugActions;
            [] call VIC_fnc_markAllBuildings;
        };
    }] call CBA_fnc_addEventHandler;
};

// Allow toggling debug mode mid-mission
["CBA_SettingChanged", {
    params ["_setting", "_value"];
    if (hasInterface && {_setting isEqualTo "VSA_debugMode" && {_value}}) then {
        [] call VIC_fnc_setupDebugActions;
        [] call VIC_fnc_markAllBuildings;
    };
}] call CBA_fnc_addEventHandler;
