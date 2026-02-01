/*
    STALKER ALife – preInit
    - Register CBA settings
    - Compile functions
    - Define constants
*/


// --- Shared initializations migrated from fn_masterInit.sqf ---
private _settings = "cba_settings.sqf";
private _start = diag_tickTime;
waitUntil {
    !isNil "CBA_fnc_addSetting" || {diag_tickTime - _start > 5}
};
if (isNil "CBA_fnc_addSetting") exitWith {
    diag_log "STALKER ALife: CBA not found - skipping initialization";
};
call compile preprocessFileLineNumbers _settings;

VIC_fnc_debugLog                 = compile preprocessFileLineNumbers ("functions\core\fn_debugLog.sqf");
["preInit"] call VIC_fnc_debugLog;

// --- Custom marker colours -------------------------------------------------
VIC_colorMutant      = "#(0.545,0.27,0.074,1)";
VIC_colorClearSky    = "#(0.529,0.808,0.922,1)";
VIC_colorDuty        = "#(0.502,0,0,1)";
VIC_colorFreedom     = "#(0.565,0.933,0.565,1)";
VIC_colorEcologists  = "#(0.941,0.902,0.549,1)";
VIC_colorBandits     = "#(0,0,0,1)";
VIC_colorLoners      = "#(0.722,0.525,0.043,1)";
VIC_colorMercs       = "#(0,0,0.545,1)";
VIC_colorWard        = "#(0.961,0.961,0.863,1)";
VIC_colorIPSF        = "#(0.804,0.498,0.196,1)";
VIC_colorMilitary    = "#(0,0.392,0,1)";
VIC_colorMonolith    = "#(0.294,0,0.510,1)";
VIC_colorCopper      = "#(0.72,0.45,0.20,1)";
VIC_colorSilver      = "#(0.75,0.75,0.75,1)";
VIC_colorFruitGreen  = "#(0,1,0,1)";
VIC_colorGasYellow   = "#(0.8,0.8,0,1)";
VIC_colorPyroOrange  = "#(1,0.647,0,1)";
VIC_colorTeleport    = "#(0.5,0,0.5,1)";
VIC_colorElectroBlue = "#(0,0,1,1)";
VIC_colorMeatRed     = "#(1,0,0,1)";
VIC_colorSpringYellow = "#(1,1,0,1)";
VIC_colorLeechGrey   = "#(0.4,0.4,0.4,1)";
VIC_colorClickerMagenta = "#(1,0,1,1)";
VIC_colorTrapdoorTurq = "#(0.251,0.878,0.816,1)";
VIC_colorZapperCyan  = "#(0,1,1,1)";
VIC_colorBridgeCyan  = "#(0,0.6,0.6,1)";

// --- Core/shared functions -------------------------------------------------
VIC_fnc_setupDebugActions        = compile preprocessFileLineNumbers ("functions\core\fn_setupDebugActions.sqf");
VIC_fnc_markAllBuildings        = compile preprocessFileLineNumbers ("functions\core\fn_markAllBuildings.sqf");
VIC_fnc_markPlayerRanges        = compile preprocessFileLineNumbers ("functions\core\fn_markPlayerRanges.sqf");
VIC_fnc_saveCache              = compile preprocessFileLineNumbers ("functions\core\fn_saveCache.sqf");
VIC_fnc_loadCache              = compile preprocessFileLineNumbers ("functions\core\fn_loadCache.sqf");
VIC_fnc_remoteReturn           = compile preprocessFileLineNumbers ("functions\core\fn_remoteReturn.sqf");
VIC_fnc_callServerHelper       = compile preprocessFileLineNumbers ("functions\core\fn_callServerHelper.sqf");
VIC_fnc_callServer             = compile preprocessFileLineNumbers ("functions\core\fn_callServer.sqf");
VIC_fnc_requestServerState     = compile preprocessFileLineNumbers ("functions\core\fn_requestServerState.sqf");
VIC_fnc_sendServerState        = compile preprocessFileLineNumbers ("functions\core\fn_sendServerState.sqf");
VIC_fnc_applyServerState       = compile preprocessFileLineNumbers ("functions\core\fn_applyServerState.sqf");
VIC_fnc_getServerMetrics       = compile preprocessFileLineNumbers ("functions\core\fn_getServerMetrics.sqf");
VIC_fnc_markSitesOverlay       = compile preprocessFileLineNumbers ("functions\core\fn_markSitesOverlay.sqf");
VIC_fnc_toggleSiteOverlay      = compile preprocessFileLineNumbers ("functions\core\fn_toggleSiteOverlay.sqf");
VIC_fnc_togglePerfMetrics      = compile preprocessFileLineNumbers ("functions\core\fn_togglePerfMetrics.sqf");
VIC_fnc_findRockClusters        = compile preprocessFileLineNumbers ("functions\core\fn_findRockClusters.sqf");
VIC_fnc_markRockClusters        = compile preprocessFileLineNumbers ("functions\core\fn_markRockClusters.sqf");
VIC_fnc_findSniperSpots        = compile preprocessFileLineNumbers ("functions\core\fn_findSniperSpots.sqf");
VIC_fnc_markSniperSpots        = compile preprocessFileLineNumbers ("functions\core\fn_markSniperSpots.sqf");
VIC_fnc_findSwamps             = compile preprocessFileLineNumbers ("functions\core\fn_findSwamps.sqf");
VIC_fnc_markSwamps             = compile preprocessFileLineNumbers ("functions\core\fn_markSwamps.sqf");
VIC_fnc_findBeachesInMap       = compile preprocessFileLineNumbers ("functions\core\fn_findBeachesInMap.sqf");
VIC_fnc_markBeaches            = compile preprocessFileLineNumbers ("functions\core\fn_markBeaches.sqf");
VIC_fnc_findValleys            = compile preprocessFileLineNumbers ("functions\core\fn_findValleys.sqf");
VIC_fnc_markValleys            = compile preprocessFileLineNumbers ("functions\core\fn_markValleys.sqf");
VIC_fnc_findLandZones         = compile preprocessFileLineNumbers ("functions\core\fn_findLandZones.sqf");
VIC_fnc_markLandZones         = compile preprocessFileLineNumbers ("functions\core\fn_markLandZones.sqf");
VIC_fnc_findBuildingClusters    = compile preprocessFileLineNumbers ("functions\core\fn_findBuildingClusters.sqf");
VIC_fnc_markBuildingClusters    = compile preprocessFileLineNumbers ("functions\core\fn_markBuildingClusters.sqf");
VIC_fnc_createGlobalMarker     = compile preprocessFileLineNumbers ("functions\core\fn_createGlobalMarker.sqf");
VIC_fnc_createLocalMarker      = compile preprocessFileLineNumbers ("functions\core\fn_createLocalMarker.sqf");
VIC_fnc_markDeathLocation      = compile preprocessFileLineNumbers ("functions\core\fn_markDeathLocation.sqf");
VIC_fnc_weightedPick           = compile preprocessFileLineNumbers ("functions\core\fn_weightedPick.sqf");
VIC_fnc_selectWeightedBuilding = compile preprocessFileLineNumbers ("functions\core\fn_selectWeightedBuilding.sqf");
VIC_fnc_findBridges            = compile preprocessFileLineNumbers ("functions\core\fn_findBridges.sqf");
VIC_fnc_markBridges            = compile preprocessFileLineNumbers ("functions\core\fn_markBridges.sqf");
VIC_fnc_findRoads             = compile preprocessFileLineNumbers ("functions\core\fn_findRoads.sqf");
VIC_fnc_findCrossroads        = compile preprocessFileLineNumbers ("functions\core\fn_findCrossroads.sqf");
VIC_fnc_markRoads             = compile preprocessFileLineNumbers ("functions\core\fn_markRoads.sqf");
VIC_fnc_markWrecks            = compile preprocessFileLineNumbers ("functions\wrecks\fn_markWrecks.sqf");
VIC_fnc_placeCachedMarkers    = compile preprocessFileLineNumbers ("functions\core\fn_placeCachedMarkers.sqf");
VIC_fnc_findHiddenPosition     = compile preprocessFileLineNumbers ("functions\core\fn_findHiddenPosition.sqf");
VIC_fnc_markHiddenPosition     = compile preprocessFileLineNumbers ("functions\core\fn_markHiddenPosition.sqf");
VIC_fnc_findBuildingCoverSpot  = compile preprocessFileLineNumbers ("functions\core\fn_findBuildingCoverSpot.sqf");
VIC_fnc_markBuildingCoverSpot  = compile preprocessFileLineNumbers ("functions\core\fn_markBuildingCoverSpot.sqf");
VIC_fnc_radioMessage          = compile preprocessFileLineNumbers ("functions\core\fn_radioMessage.sqf");
VIC_fnc_initMap               = compile preprocessFileLineNumbers ("functions\core\fn_initMap.sqf");
VIC_fnc_regenMapPoints       = compile preprocessFileLineNumbers ("functions\core\fn_regenMapPoints.sqf");
VIC_fnc_initManagers          = compile preprocessFileLineNumbers ("functions\core\fn_initManagers.sqf");
