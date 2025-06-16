/*
    Master initialization for STALKER ALife.
    This sets up CBA settings, registers every function as a CBA XEH
    handler and kicks off emission related hooks.
*/

// --- CBA Settings -----------------------------------------------------------
private _root = "\Viceroys-STALKER-ALife";
private _settings = _root + "\cba_settings.sqf";
waitUntil {!isNil "CBA_fnc_addSetting"};
call compile preprocessFileLineNumbers _settings;

// Compile logging function first so it can be used immediately
VIC_fnc_debugLog                 = compile preprocessFileLineNumbers (_root + "\functions\core\fn_debugLog.sqf");

["masterInit"] call VIC_fnc_debugLog;

// Functions required on both server and client for debugging helpers
VIC_fnc_setupDebugActions        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_setupDebugActions.sqf");
VIC_fnc_markAllBuildings        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markAllBuildings.sqf");
VIC_fnc_markPlayerRanges        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markPlayerRanges.sqf");
VIC_fnc_findRockClusters        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findRockClusters.sqf");
VIC_fnc_markRockClusters        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markRockClusters.sqf");
VIC_fnc_findSniperSpots        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findSniperSpots.sqf");
VIC_fnc_markSniperSpots        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markSniperSpots.sqf");
VIC_fnc_findSwamps             = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findSwamps.sqf");
VIC_fnc_markSwamps             = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markSwamps.sqf");
VIC_fnc_findBeachesInMap       = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findBeachesInMap.sqf");
VIC_fnc_markBeaches            = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markBeaches.sqf");
VIC_fnc_findValleys            = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findValleys.sqf");
VIC_fnc_markValleys            = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markValleys.sqf");
VIC_fnc_findBuildingClusters    = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findBuildingClusters.sqf");
VIC_fnc_markBuildingClusters    = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markBuildingClusters.sqf");
VIC_fnc_createGlobalMarker     = compile preprocessFileLineNumbers (_root + "\functions\core\fn_createGlobalMarker.sqf");
VIC_fnc_createLocalMarker      = compile preprocessFileLineNumbers (_root + "\functions\core\fn_createLocalMarker.sqf");
VIC_fnc_markDeathLocation      = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markDeathLocation.sqf");
VIC_fnc_weightedPick           = compile preprocessFileLineNumbers (_root + "\functions\core\fn_weightedPick.sqf");
VIC_fnc_selectWeightedBuilding = compile preprocessFileLineNumbers (_root + "\functions\core\fn_selectWeightedBuilding.sqf");
VIC_fnc_findBridges            = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findBridges.sqf");
VIC_fnc_markBridges            = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markBridges.sqf");
VIC_fnc_findHiddenPosition     = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findHiddenPosition.sqf");
VIC_fnc_markHiddenPosition     = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markHiddenPosition.sqf");
VIC_fnc_findBuildingCoverSpot  = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findBuildingCoverSpot.sqf");
VIC_fnc_markBuildingCoverSpot  = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markBuildingCoverSpot.sqf");
VIC_fnc_radioMessage          = compile preprocessFileLineNumbers (_root + "\functions\core\fn_radioMessage.sqf");

if (isServer) then {

// --- Function Registration -------------------------------------------------
VIC_fnc_resetAIBehavior          = compile preprocessFileLineNumbers (_root + "\functions\ai\fn_resetAIBehavior.sqf");
    VIC_fnc_triggerAIPanic           = compile preprocessFileLineNumbers (_root + "\functions\ai\fn_triggerAIPanic.sqf");
    VIC_fnc_avoidAnomalies           = compile preprocessFileLineNumbers (_root + "\functions\ai\fn_avoidAnomalies.sqf");
    VIC_fnc_avoidAnomalyFields       = compile preprocessFileLineNumbers (_root + "\functions\ai\fn_avoidAnomalyFields.sqf");
    VIC_fnc_toggleFieldAvoid         = compile preprocessFileLineNumbers (_root + "\functions\ai\fn_toggleFieldAvoid.sqf");
VIC_fnc_cleanupChemicalZones    = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_cleanupChemicalZones.sqf");
VIC_fnc_spawnChemicalZone       = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_spawnChemicalZone.sqf");
VIC_fnc_spawnRandomChemicalZones = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_spawnRandomChemicalZones.sqf");
VIC_fnc_findValleyPosition      = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_findValleyPosition.sqf");
VIC_fnc_spawnValleyChemicalZones = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_spawnValleyChemicalZones.sqf");
VIC_fnc_manageChemicalZones     = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_manageChemicalZones.sqf");
VIC_fnc_spawnZombiesFromQueue    = compile preprocessFileLineNumbers (_root + "\functions\zombification\fn_spawnZombiesFromQueue.sqf");
VIC_fnc_trackDeadForZombify      = compile preprocessFileLineNumbers (_root + "\functions\zombification\fn_trackDeadForZombify.sqf");
VIC_fnc_spawnAllAnomalyFields    = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_spawnAllAnomalyFields.sqf");
VIC_fnc_cycleAnomalyFields       = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_cycleAnomalyFields.sqf");
VIC_fnc_cleanupAnomalyMarkers    = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_cleanupAnomalyMarkers.sqf");
VIC_fnc_manageAnomalyFields     = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_manageAnomalyFields.sqf");
VIC_fnc_generateFieldName       = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_generateFieldName.sqf");
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
VIC_fnc_scheduleBlowouts         = compile preprocessFileLineNumbers (_root + "\functions\blowouts\fn_scheduleBlowouts.sqf");
VIC_fnc_triggerBlowout           = compile preprocessFileLineNumbers (_root + "\functions\blowouts\fn_triggerBlowout.sqf");
VIC_fnc_triggerNecroplague  = compile preprocessFileLineNumbers (_root + "\functions\necroplague\fn_triggerNecroplague.sqf");
VIC_fnc_scheduleNecroplague = compile preprocessFileLineNumbers (_root + "\functions\necroplague\fn_scheduleNecroplague.sqf");
VIC_fnc_placeTownSirens          = compile preprocessFileLineNumbers (_root + "\functions\blowouts\fn_placeTownSirens.sqf");
VIC_fnc_setupSpookZones          = compile preprocessFileLineNumbers (_root + "\functions\spooks\fn_setupSpookZones.sqf");
VIC_fnc_spawnSpookZone           = compile preprocessFileLineNumbers (_root + "\functions\spooks\fn_spawnSpookZone.sqf");
VIC_fnc_spawnMutantGroup         = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnMutantGroup.sqf");
VIC_fnc_spawnMinefields        = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_spawnMinefields.sqf");
VIC_fnc_spawnAPERSField        = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_spawnAPERSField.sqf");
VIC_fnc_spawnIED               = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_spawnIED.sqf");
VIC_fnc_spawnBoobyTraps        = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_spawnBoobyTraps.sqf");
VIC_fnc_manageMinefields       = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_manageMinefields.sqf");
VIC_fnc_spawnAbandonedVehicles = compile preprocessFileLineNumbers (_root + "\functions\wrecks\fn_spawnAbandonedVehicles.sqf");
VIC_fnc_startMinefieldManager  = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_startMinefieldManager.sqf");
VIC_fnc_spawnAmbushes          = compile preprocessFileLineNumbers (_root + "\functions\ambushes\fn_spawnAmbushes.sqf");
VIC_fnc_manageAmbushes         = compile preprocessFileLineNumbers (_root + "\functions\ambushes\fn_manageAmbushes.sqf");
VIC_fnc_startAmbushManager     = compile preprocessFileLineNumbers (_root + "\functions\ambushes\fn_startAmbushManager.sqf");
VIC_fnc_setupAnomalyFields      = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_setupAnomalyFields.sqf");
VIC_fnc_spawnAmbientHerds        = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnAmbientHerds.sqf");
VIC_fnc_setupMutantHabitats      = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_setupMutantHabitats.sqf");
VIC_fnc_spawnMutantNest         = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnMutantNest.sqf");
VIC_fnc_spawnBloodsuckerNest     = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnBloodsuckerNest.sqf");
VIC_fnc_spawnBoarNest           = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnBoarNest.sqf");
VIC_fnc_spawnCatNest            = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnCatNest.sqf");
VIC_fnc_spawnFleshNest          = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnFleshNest.sqf");
VIC_fnc_spawnBlindDogNest       = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnBlindDogNest.sqf");
VIC_fnc_spawnPseudodogNest      = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnPseudodogNest.sqf");
VIC_fnc_spawnSnorkNest         = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnSnorkNest.sqf");
VIC_fnc_spawnControllerNest     = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnControllerNest.sqf");
VIC_fnc_spawnPseudogiantNest    = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnPseudogiantNest.sqf");
VIC_fnc_spawnIzlomNest          = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnIzlomNest.sqf");
VIC_fnc_spawnCorruptorNest      = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnCorruptorNest.sqf");
VIC_fnc_spawnSmasherNest        = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnSmasherNest.sqf");
VIC_fnc_spawnAcidSmasherNest    = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnAcidSmasherNest.sqf");
VIC_fnc_spawnBehemothNest       = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnBehemothNest.sqf");
VIC_fnc_spawnPredatorAttack     = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnPredatorAttack.sqf");
VIC_fnc_managePredators         = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_managePredators.sqf");
VIC_fnc_manageHerds              = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageHerds.sqf");
VIC_fnc_manageHostiles           = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageHostiles.sqf");
VIC_fnc_manageNests              = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageNests.sqf");
VIC_fnc_manageHabitats           = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageHabitats.sqf");
VIC_fnc_updateProximity          = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_updateProximity.sqf");
VIC_fnc_onMutantKilled           = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_onMutantKilled.sqf");
VIC_fnc_initMutantUnit          = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_initMutantUnit.sqf");
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
VIC_fnc_getSurfacePosition       = compile preprocessFileLineNumbers (_root + "\functions\core\fn_getSurfacePosition.sqf");
VIC_fnc_isWaterPosition         = compile preprocessFileLineNumbers (_root + "\functions\core\fn_isWaterPosition.sqf");
VIC_fnc_findLandPosition        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findLandPosition.sqf");
VIC_fnc_getLandSurfacePosition  = compile preprocessFileLineNumbers (_root + "\functions\core\fn_getLandSurfacePosition.sqf");
VIC_fnc_findRoadPosition        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findRoadPosition.sqf");
VIC_fnc_findRandomRoadPosition  = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findRandomRoadPosition.sqf");
VIC_fnc_spawnAmbientStalkers   = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_spawnAmbientStalkers.sqf");
VIC_fnc_spawnStalkerCamp       = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_spawnStalkerCamp.sqf");
VIC_fnc_spawnStalkerCamps      = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_spawnStalkerCamps.sqf");
VIC_fnc_manageStalkerCamps     = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_manageStalkerCamps.sqf");

VIC_fnc_isAntistasiUltimate  = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_isAntistasiUltimate.sqf");
VIC_fnc_startMutantHunt      = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_startMutantHunt.sqf");
VIC_fnc_startArtefactHunt    = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_startArtefactHunt.sqf");
VIC_fnc_startChemSample      = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_startChemSample.sqf");
VIC_fnc_completeArtefactHunt = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_completeArtefactHunt.sqf");
VIC_fnc_completeChemSample   = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_completeChemSample.sqf");

// --- PostInit ---------------------------------------------------------------
["postInit", {
    [] call VIC_fnc_registerEmissionHooks;
    [] call VIC_fnc_schedulePsyStorms;
    [] call VIC_fnc_scheduleBlowouts;
    [] call VIC_fnc_scheduleNecroplague;
    [] call VIC_fnc_placeTownSirens;
    [] call VIC_fnc_setupAnomalyFields;
    [] call VIC_fnc_setupMutantHabitats;
    [] call VIC_fnc_spawnAmbientStalkers;
    [] call VIC_fnc_spawnStalkerCamps;
    [
        {
            while {true} do {
                [] call VIC_fnc_updateProximity;
                private _delay = ["VSA_proximityCheckInterval", 5] call VIC_fnc_getSetting;
                sleep _delay;
            };
        }, [], 8
    ] call CBA_fnc_waitAndExecute;
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
                [] call VIC_fnc_manageChemicalZones;
                sleep 60;
            };
        }, [], 13
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
                [] call VIC_fnc_avoidAnomalies;
                sleep 30;
            };
        }, [], 16
    ] call CBA_fnc_waitAndExecute;

    [
        {
            while {true} do {
                [] call VIC_fnc_avoidAnomalyFields;
                sleep 30;
            };
        }, [], 17
    ] call CBA_fnc_waitAndExecute;

    [
        {
            while {true} do {
                [] call VIC_fnc_manageAnomalyFields;
                sleep 60;
            };
        }, [], 18
    ] call CBA_fnc_waitAndExecute;

    [
        {
            while {true} do {
                [] call VIC_fnc_manageNests;
                sleep 300;
            };
        }, [], 20
    ] call CBA_fnc_waitAndExecute;

    [
        {
            while {true} do {
                [] call VIC_fnc_managePredators;
                private _day   = ["VSA_predatorCheckIntervalDay", 300] call VIC_fnc_getSetting;
                private _night = ["VSA_predatorCheckIntervalNight", 300] call VIC_fnc_getSetting;
                private _delay = if (daytime > 5 && daytime < 20) then {_day} else {_night};
                sleep _delay;
            };
        }, [], 23
    ] call CBA_fnc_waitAndExecute;

    [
        {
            while {true} do {
                [] call VIC_fnc_manageHabitats;
                private _delay = ["VSA_habitatCheckInterval", 5] call VIC_fnc_getSetting;
                sleep _delay;
            };
        }, [], 25
    ] call CBA_fnc_waitAndExecute;

    [
        {
            while {true} do {
                [] call VIC_fnc_manageStalkerCamps;
                sleep 60;
            };
        }, [], 29
    ] call CBA_fnc_waitAndExecute;
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        [] call VIC_fnc_setupDebugActions;
        [] call VIC_fnc_markPlayerRanges;
    };
}] call CBA_fnc_addEventHandler;

["masterInit completed"] call VIC_fnc_debugLog;
// Track units killed during emissions for later zombification
["EntityKilled", {
    params ["_unit"];
    [_unit] call VIC_fnc_trackDeadForZombify;
    [_unit] call VIC_fnc_markDeathLocation;
  }] call CBA_fnc_addEventHandler;
} else {
    ["postInit", {
        if (hasInterface) then {
            [] call VIC_fnc_markPlayerRanges;
            if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
                [] call VIC_fnc_setupDebugActions;
            };
        };
    }] call CBA_fnc_addEventHandler;
};

// Allow toggling debug mode mid-mission
["CBA_SettingChanged", {
    params ["_setting", "_value"];
    if (hasInterface && {_setting isEqualTo "VSA_debugMode" && {_value}}) then {
        [] call VIC_fnc_setupDebugActions;
        [] call VIC_fnc_markPlayerRanges;
    };
}] call CBA_fnc_addEventHandler;
