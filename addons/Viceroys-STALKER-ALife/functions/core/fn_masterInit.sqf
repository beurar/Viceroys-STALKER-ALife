/*
    Master initialization for STALKER ALife.
    This sets up CBA settings, registers every function as a CBA XEH
    handler and kicks off emission related hooks.
*/

// --- CBA Settings -----------------------------------------------------------
private _root = "Viceroys-STALKER-ALife";
private _settings = _root + "\cba_settings.sqf";

// Wait briefly for CBA to become available so initialization doesn't hang
private _start = diag_tickTime;
waitUntil {
    !isNil "CBA_fnc_addSetting" || {diag_tickTime - _start > 5}
};
if (isNil "CBA_fnc_addSetting") exitWith {
    diag_log "STALKER ALife: CBA not found - skipping initialization";
};

call compile preprocessFileLineNumbers _settings;

// Compile logging function first so it can be used immediately
VIC_fnc_debugLog                 = compile preprocessFileLineNumbers (_root + "\functions\core\fn_debugLog.sqf");
// Settings helper is required by the logger

["masterInit"] call VIC_fnc_debugLog;

// --- Custom marker colours -------------------------------------------------
VIC_colorMutant      = "#(0.545,0.27,0.074,1)";   // Brown
VIC_colorClearSky    = "#(0.529,0.808,0.922,1)";   // Sky blue
VIC_colorDuty        = "#(0.502,0,0,1)";           // Maroon
VIC_colorFreedom     = "#(0.565,0.933,0.565,1)";   // Light green
VIC_colorEcologists  = "#(0.941,0.902,0.549,1)";   // Khaki
VIC_colorBandits     = "#(0,0,0,1)";               // Black
VIC_colorLoners      = "#(0.722,0.525,0.043,1)";   // Dark yellow
VIC_colorMercs       = "#(0,0,0.545,1)";           // Dark blue
VIC_colorWard        = "#(0.961,0.961,0.863,1)";   // Beige
VIC_colorIPSF        = "#(0.804,0.498,0.196,1)";   // Bronze
VIC_colorMilitary    = "#(0,0.392,0,1)";           // Dark green
VIC_colorMonolith    = "#(0.294,0,0.510,1)";       // Dark purple
VIC_colorCopper      = "#(0.72,0.45,0.20,1)";      // Copper
VIC_colorSilver      = "#(0.75,0.75,0.75,1)";      // Silver
VIC_colorFruitGreen  = "#(0,1,0,1)";               // Bright green
VIC_colorGasYellow   = "#(0.8,0.8,0,1)";           // Sickly yellow
VIC_colorPyroOrange  = "#(1,0.647,0,1)";           // Orange
VIC_colorTeleport    = "#(0.5,0,0.5,1)";           // Purple
VIC_colorElectroBlue = "#(0,0,1,1)";               // Blue
VIC_colorMeatRed     = "#(1,0,0,1)";               // Red
VIC_colorSpringYellow = "#(1,1,0,1)";              // Yellow
VIC_colorLeechGrey   = "#(0.4,0.4,0.4,1)";         // Dark grey
VIC_colorClickerMagenta = "#(1,0,1,1)";            // Magenta
VIC_colorTrapdoorTurq = "#(0.251,0.878,0.816,1)";  // Turquoise
VIC_colorZapperCyan  = "#(0,1,1,1)";               // Cyan
VIC_colorBridgeCyan  = "#(0,0.6,0.6,1)";           // Dark cyan

// Functions required on both server and client for debugging helpers
VIC_fnc_setupDebugActions        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_setupDebugActions.sqf");
VIC_fnc_markAllBuildings        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markAllBuildings.sqf");
VIC_fnc_markPlayerRanges        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markPlayerRanges.sqf");
VIC_fnc_saveCache              = compile preprocessFileLineNumbers (_root + "\functions\core\fn_saveCache.sqf");
VIC_fnc_loadCache              = compile preprocessFileLineNumbers (_root + "\functions\core\fn_loadCache.sqf");
VIC_fnc_remoteReturn           = compile preprocessFileLineNumbers (_root + "\functions\core\fn_remoteReturn.sqf");
VIC_fnc_callServerHelper       = compile preprocessFileLineNumbers (_root + "\functions\core\fn_callServerHelper.sqf");
VIC_fnc_callServer             = compile preprocessFileLineNumbers (_root + "\functions\core\fn_callServer.sqf");
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
VIC_fnc_findLandZones         = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findLandZones.sqf");
VIC_fnc_markLandZones         = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markLandZones.sqf");
VIC_fnc_findBuildingClusters    = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findBuildingClusters.sqf");
VIC_fnc_markBuildingClusters    = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markBuildingClusters.sqf");
VIC_fnc_createGlobalMarker     = compile preprocessFileLineNumbers (_root + "\functions\core\fn_createGlobalMarker.sqf");
VIC_fnc_createLocalMarker      = compile preprocessFileLineNumbers (_root + "\functions\core\fn_createLocalMarker.sqf");
VIC_fnc_markDeathLocation      = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markDeathLocation.sqf");
VIC_fnc_weightedPick           = compile preprocessFileLineNumbers (_root + "\functions\core\fn_weightedPick.sqf");
VIC_fnc_selectWeightedBuilding = compile preprocessFileLineNumbers (_root + "\functions\core\fn_selectWeightedBuilding.sqf");
VIC_fnc_findBridges            = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findBridges.sqf");
VIC_fnc_markBridges            = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markBridges.sqf");
VIC_fnc_findRoads             = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findRoads.sqf");
VIC_fnc_findCrossroads        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findCrossroads.sqf");
VIC_fnc_markRoads             = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markRoads.sqf");
VIC_fnc_markWrecks            = compile preprocessFileLineNumbers (_root + "\functions\wrecks\fn_markWrecks.sqf");
VIC_fnc_placeCachedMarkers    = compile preprocessFileLineNumbers (_root + "\functions\core\fn_placeCachedMarkers.sqf");
VIC_fnc_findHiddenPosition     = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findHiddenPosition.sqf");
VIC_fnc_markHiddenPosition     = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markHiddenPosition.sqf");
VIC_fnc_findBuildingCoverSpot  = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findBuildingCoverSpot.sqf");
VIC_fnc_markBuildingCoverSpot  = compile preprocessFileLineNumbers (_root + "\functions\core\fn_markBuildingCoverSpot.sqf");
VIC_fnc_radioMessage          = compile preprocessFileLineNumbers (_root + "\functions\core\fn_radioMessage.sqf");
VIC_fnc_initMap               = compile preprocessFileLineNumbers (_root + "\functions\core\fn_initMap.sqf");
VIC_fnc_regenMapPoints       = compile preprocessFileLineNumbers (_root + "\functions\core\fn_regenMapPoints.sqf");
VIC_fnc_initManagers          = compile preprocessFileLineNumbers (_root + "\functions\core\fn_initManagers.sqf");

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
VIC_fnc_spawnValleyChemicalFields = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_spawnValleyChemicalFields.sqf");
VIC_fnc_expandValley           = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_expandValley.sqf");
VIC_fnc_manageChemicalZones     = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_manageChemicalZones.sqf");
VIC_fnc_spawnZombiesFromQueue    = compile preprocessFileLineNumbers (_root + "\functions\zombification\fn_spawnZombiesFromQueue.sqf");
VIC_fnc_trackDeadForZombify      = compile preprocessFileLineNumbers (_root + "\functions\zombification\fn_trackDeadForZombify.sqf");
VIC_fnc_spawnAllAnomalyFields    = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_spawnAllAnomalyFields.sqf");
VIC_fnc_spawnBridgeAnomalyFields = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_spawnBridgeAnomalyFields.sqf");
VIC_fnc_cycleAnomalyFields       = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_cycleAnomalyFields.sqf");
VIC_fnc_cleanupAnomalyMarkers    = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_cleanupAnomalyMarkers.sqf");
VIC_fnc_manageAnomalyFields     = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_manageAnomalyFields.sqf");
VIC_fnc_startAnomalyManager     = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_startAnomalyManager.sqf");
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
VIC_fnc_createField_bridgeAnomaly = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fields\fn_createField_bridgeAnomaly.sqf");
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
VIC_fnc_spawnIEDSites         = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_spawnIEDSites.sqf");
VIC_fnc_manageIEDSites        = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_manageIEDSites.sqf");
VIC_fnc_startIEDManager       = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_startIEDManager.sqf");
VIC_fnc_spawnBoobyTraps        = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_spawnBoobyTraps.sqf");
VIC_fnc_spawnTripwirePerimeter = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_spawnTripwirePerimeter.sqf");
VIC_fnc_manageMinefields       = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_manageMinefields.sqf");
VIC_fnc_manageBoobyTraps       = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_manageBoobyTraps.sqf");
VIC_fnc_spawnAbandonedVehicles = compile preprocessFileLineNumbers (_root + "\functions\wrecks\fn_spawnAbandonedVehicles.sqf");
VIC_fnc_findWrecks           = compile preprocessFileLineNumbers (_root + "\functions\wrecks\fn_findWrecks.sqf");
VIC_fnc_manageWrecks         = compile preprocessFileLineNumbers (_root + "\functions\wrecks\fn_manageWrecks.sqf");
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
VIC_fnc_spawnHabitatHunters    = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnHabitatHunters.sqf");
VIC_fnc_spawnCachedHabitats   = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_spawnCachedHabitats.sqf");
VIC_fnc_managePredators         = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_managePredators.sqf");
VIC_fnc_manageHerds              = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageHerds.sqf");
VIC_fnc_manageHostiles           = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageHostiles.sqf");
VIC_fnc_manageNests              = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageNests.sqf");
VIC_fnc_manageHabitats           = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_manageHabitats.sqf");
VIC_fnc_updateProximity          = compile preprocessFileLineNumbers (_root + "\functions\mutants\fn_updateProximity.sqf");
// Activity grid removed - use simple radius checks instead
minefields_fnc_activateSite   = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_activateSite.sqf");
minefields_fnc_deactivateSite = compile preprocessFileLineNumbers (_root + "\functions\minefields\fn_deactivateSite.sqf");
chemical_fnc_activateSite     = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_activateSite.sqf");
chemical_fnc_deactivateSite   = compile preprocessFileLineNumbers (_root + "\functions\chemical\fn_deactivateSite.sqf");
anomalies_fnc_activateSite    = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_activateSite.sqf");
anomalies_fnc_deactivateSite  = compile preprocessFileLineNumbers (_root + "\functions\anomalies\fn_deactivateSite.sqf");
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
VIC_fnc_getSurfacePosition       = compile preprocessFileLineNumbers (_root + "\functions\core\fn_getSurfacePosition.sqf");
VIC_fnc_isWaterPosition         = compile preprocessFileLineNumbers (_root + "\functions\core\fn_isWaterPosition.sqf");
VIC_fnc_findLandPosition       = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findLandPosition.sqf");
VIC_fnc_findLandPos = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findLandPos.sqf");
VIC_fnc_getLandSurfacePosition  = compile preprocessFileLineNumbers (_root + "\functions\core\fn_getLandSurfacePosition.sqf");
VIC_fnc_findRoadPosition        = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findRoadPosition.sqf");
VIC_fnc_findRandomRoadPosition  = compile preprocessFileLineNumbers (_root + "\functions\core\fn_findRandomRoadPosition.sqf");
VIC_fnc_getRandomRoad           = compile preprocessFileLineNumbers (_root + "\functions\core\fn_getRandomRoad.sqf");
VIC_fnc_evalSiteProximity      = compile preprocessFileLineNumbers (_root + "\functions\core\fn_evalSiteProximity.sqf");
VIC_fnc_createProximityAnchor  = compile preprocessFileLineNumbers (_root + "\functions\core\fn_createProximityAnchor.sqf");
VIC_fnc_spawnAmbientStalkers   = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_spawnAmbientStalkers.sqf");
VIC_fnc_spawnStalkerCamp       = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_spawnStalkerCamp.sqf");
VIC_fnc_spawnStalkerCamps      = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_spawnStalkerCamps.sqf");
VIC_fnc_findCampBuilding       = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_findCampBuilding.sqf");
VIC_fnc_spawnFlareTripwires    = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_spawnFlareTripwires.sqf");
VIC_fnc_spawnSniper           = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_spawnSniper.sqf");
VIC_fnc_manageSnipers         = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_manageSnipers.sqf");
VIC_fnc_startSniperManager    = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_startSniperManager.sqf");
VIC_fnc_startCampManager     = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_startCampManager.sqf");
VIC_fnc_manageStalkerCamps     = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_manageStalkerCamps.sqf");
VIC_fnc_manageWanderers       = compile preprocessFileLineNumbers (_root + "\functions\stalkers\fn_manageWanderers.sqf");

VIC_fnc_isAntistasiUltimate  = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_isAntistasiUltimate.sqf");
VIC_fnc_startMutantHunt      = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_startMutantHunt.sqf");
VIC_fnc_startArtefactHunt    = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_startArtefactHunt.sqf");
VIC_fnc_startChemSample      = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_startChemSample.sqf");
VIC_fnc_completeArtefactHunt = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_completeArtefactHunt.sqf");
VIC_fnc_completeChemSample   = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_completeChemSample.sqf");
VIC_fnc_disableA3UWeather    = compile preprocessFileLineNumbers (_root + "\functions\antistasi\fn_disableWeather.sqf");

// --- PostInit ---------------------------------------------------------------
["postInit", {
    missionNamespace setVariable ["STALKER_activityRadius", ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting];
    [] call VIC_fnc_registerEmissionHooks;
    if (call VIC_fnc_isAntistasiUltimate && { ["VSA_disableA3UWeather", false] call VIC_fnc_getSetting }) then {
        [] call VIC_fnc_disableA3UWeather;
    };
    if (isServer && {isNil "VIC_activityThread"}) then {
        VIC_activityThread = [] spawn {
            sleep 8;
            while {true} do {
                [] call VIC_fnc_updateProximity;
                sleep 6;
            };
        };
        // Additional managers have been disabled for quicker startup and can be
        // invoked via debug actions when needed.
    };
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        [] call VIC_fnc_setupDebugActions;
        [] remoteExec ["VIC_fnc_markPlayerRanges", 0];
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
        if (hasInterface && {["VSA_debugMode", false] call VIC_fnc_getSetting}) then {
            [] call VIC_fnc_setupDebugActions;
        };
    }] call CBA_fnc_addEventHandler;
};

// Allow toggling debug mode mid-mission
["CBA_SettingChanged", {
    params ["_setting", "_value"];
    if (_setting isEqualTo "VSA_debugMode") then {
        if (hasInterface) then {
            if (_value) then {
                [] call VIC_fnc_setupDebugActions;
                [] call VIC_fnc_markPlayerRanges;
            } else {
                if (!isNil "STALKER_playerRangeMarker" &&
                    {STALKER_playerRangeMarker != ""}) then {
                    deleteMarkerLocal STALKER_playerRangeMarker;
                };
                STALKER_playerRangeMarker = "";
                missionNamespace setVariable ["VSA_rangeMarkersActive", false];
            };
        };
    };
}] call CBA_fnc_addEventHandler;
