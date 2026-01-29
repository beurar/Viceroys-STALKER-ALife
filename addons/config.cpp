class CfgPatches
{
    class VIC_StalkerALife
    {
        requiredVersion = 2.02;
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Functions_F",
            "CBA_Extended_EventHandlers",
            "cba_main"
        };
    };
};

class CfgFunctions
{
    class VIC
    {
        tag = "VIC";

        class Core
        {
            file = "vicstalker\core\functions\core";
            class masterInit{};
            class registerEmissionHooks{};
            class getSetting{};
            class getSurfacePosition{};
            class hasPlayersNearby{};
            class createGlobalMarker{};
            class createLocalMarker{};
            class createProximityAnchor{};
            class weightedPick{};
            class selectWeightedBuilding{};
            class findBridges{};
            class radioMessage{};
            class sitePlaced{};
            class activateSite{};
            class deactivateSite{};
            class requestServerState{};
            class sendServerState{};
            class applyServerState{};
            class getServerMetrics{};
            class markSitesOverlay{};
            class toggleSiteOverlay{};
            class togglePerfMetrics{};
        };

        class AI
        {
            file = "vicstalker\ai\functions\ai";
            class resetAIBehavior{};
            class triggerAIPanic{};
            class avoidAnomalies{};
            class avoidAnomalyFields{};
            class toggleFieldAvoid{};
        };

        class Panic
        {
            file = "vicstalker\panic\functions\panic";
            class onEmissionBuildUp{};
            class onEmissionStart{};
            class onEmissionEnd{};
        };

        class Mutants
        {
            file = "vicstalker\mutants\functions\mutants";
            class spawnAmbientHerds{};
            class spawnMutantGroup{};
            class spawnMutantNest{};
            class spawnBloodsuckerNest{};
            class spawnBoarNest{};
            class spawnCatNest{};
            class spawnFleshNest{};
            class spawnBlindDogNest{};
            class spawnPseudodogNest{};
            class spawnSnorkNest{};
            class spawnControllerNest{};
            class spawnPseudogiantNest{};
            class spawnIzlomNest{};
            class spawnCorruptorNest{};
            class spawnSmasherNest{};
            class spawnAcidSmasherNest{};
            class spawnBehemothNest{};
            class isMutantEnabled{};
            class manageHerds{};
            class manageHostiles{};
            class manageNests{};
            class manageHabitats{};
            class setupMutantHabitats{};
            class spawnCachedHabitats{};
            class onEmissionStart{};
            class onEmissionEnd{};
        };
        class Stalkers
        {
            file = "vicstalker\stalkers\functions\stalkers";
            class spawnAmbientStalkers{};
            class spawnStalkerCamp{};
            class spawnStalkerCamps{};
            class findCampBuilding{};
            class spawnFlareTripwires{};
            class spawnSniper{};
            class manageSnipers{};
            class startSniperManager{};
            class startCampManager{};
            class manageStalkerCamps{};
            class manageWanderers{};
        };


        class Chemical
        {
            file = "vicstalker\chemical\functions\chemical";
            class cleanupChemicalZones{};
            class spawnChemicalZone{};
            class spawnRandomChemicalZones{};
            class activateSite{};
            class deactivateSite{};
            class onEmissionStart{};
            class onEmissionEnd{};
        };

        class Spooks
        {
            file = "vicstalker\spooks\functions\spooks";
            class setupSpookZones{};
            class spawnSpookZone{};
            class manageSpookZones{};
        };
        class Minefields
        {
            file = "vicstalker\minefields\functions\minefields";
            class spawnMinefields{};
            class spawnAPERSField{};
            class spawnIED{};
            class spawnIEDSites{};
            class manageIEDSites{};
            class startIEDManager{};
            class spawnBoobyTraps{};
            class spawnTripwirePerimeter{};
            class activateSite{};
            class deactivateSite{};
            class manageMinefields{};
            class manageBoobyTraps{};
            class startMinefieldManager{};
        };
        class Wrecks
        {
            file = "vicstalker\wrecks\functions\wrecks";
            class spawnAbandonedVehicles{};
            class findWrecks{};
            class manageWrecks{};
        };

        class Ambushes
        {
            file = "vicstalker\ambushes\functions\ambushes";
            class spawnAmbushes{};
            class manageAmbushes{};
            class startAmbushManager{};
        };
        class Blowouts
        {
            file = "vicstalker\blowouts\functions\blowouts";
            class scheduleBlowouts{};
            class triggerBlowout{};
            class placeTownSirens{};
        };

        class Storms
        {
            file = "vicstalker\storms\functions\storms";
            class schedulePsyStorms{};
            class triggerPsyStorm{};
        };

        class Zombification
        {
            file = "VIC\functions\zombification";
            class spawnZombiesFromQueue{};
            class trackDeadForZombify{};
            class onEmissionEnd{};
        };
        class Necroplague
        {
            file = "VIC\functions\necroplague";
            class triggerNecroplague{};
            class scheduleNecroplague{};
        };

        class Anomalies
        {
            file = "VIC\functions\anomalies";
            class spawnAllAnomalyFields{};
            class spawnBridgeAnomalyFields{};
            class cleanupAnomalyMarkers{};
            class manageAnomalyFields{};
            class startAnomalyManager{};
            class activateSite{};
            class deactivateSite{};
            class onEmissionBuildUp{};
            class onEmissionStart{};
            class onEmissionEnd{};
        };

        class AnomalyFields
        {
            file = "VIC\functions\anomalies\fields";
            class createField_burner{};
            class createField_clicker{};
            class createField_electra{};
            class createField_fruitpunch{};
            class createField_gravi{};
            class createField_meatgrinder{};
            class createField_springboard{};
            class createField_whirligig{};
            class createField_launchpad{};
            class createField_leech{};
            class createField_trapdoor{};
            class createField_zapper{};
            class createField_razor{};
            class createField_bridgeAnomaly{};
        };

        class AnomalyFindSites
        {
            file = "VIC\functions\anomalies\find_sites";
            class findSite_burner{};
            class findSite_clicker{};
            class findSite_electra{};
            class findSite_fruitpunch{};
            class findSite_gravi{};
            class findSite_meatgrinder{};
            class findSite_springboard{};
            class findSite_whirligig{};
            class findSite_launchpad{};
            class findSite_leech{};
            class findSite_trapdoor{};
            class findSite_zapper{};
            class findSite_razor{};
            class findSite_bridge{};
        };

        class Antistasi
        {
            file = "VIC\functions\antistasi";
            class isAntistasiUltimate{};
            class startMutantHunt{};
            class startArtefactHunt{};
            class startChemSample{};
            class completeArtefactHunt{};
            class completeChemSample{};
            class disableWeather{};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_triggerPsyStorm     { allowedTargets = 2; };
        class VIC_fnc_triggerBlowout      { allowedTargets = 2; };
        class VIC_fnc_spawnChemicalZone   { allowedTargets = 2; };
        class VIC_fnc_spawnRandomChemicalZones { allowedTargets = 2; };
        class VIC_fnc_spawnValleyChemicalZones { allowedTargets = 2; };
        class VIC_fnc_spawnValleyChemicalFields { allowedTargets = 2; };
        class VIC_fnc_spawnAllAnomalyFields    { allowedTargets = 2; };
        class VIC_fnc_spawnBridgeAnomalyFields { allowedTargets = 2; };
        class VIC_fnc_cycleAnomalyFields  { allowedTargets = 2; };
        class VIC_fnc_spawnMutantGroup    { allowedTargets = 2; };
        class VIC_fnc_spawnSpookZone      { allowedTargets = 2; };
        class VIC_fnc_spawnZombiesFromQueue { allowedTargets = 2; };
        class VIC_fnc_triggerNecroplague  { allowedTargets = 2; };
        class VIC_fnc_spawnAmbientHerds   { allowedTargets = 2; };
        class VIC_fnc_spawnAmbientStalkers { allowedTargets = 2; };
        class VIC_fnc_spawnStalkerCamps   { allowedTargets = 2; };
        class VIC_fnc_spawnSniper         { allowedTargets = 2; };
        class VIC_fnc_startSniperManager  { allowedTargets = 2; };
        class VIC_fnc_startCampManager   { allowedTargets = 2; };
        class VIC_fnc_spawnPredatorAttack { allowedTargets = 2; };
        class VIC_fnc_spawnHabitatHunters { allowedTargets = 2; };
        class VIC_fnc_spawnMinefields     { allowedTargets = 2; };
        class VIC_fnc_spawnIEDSites       { allowedTargets = 2; };
        class VIC_fnc_startIEDManager     { allowedTargets = 2; };
        class VIC_fnc_spawnBoobyTraps     { allowedTargets = 2; };
        class VIC_fnc_spawnTripwirePerimeter { allowedTargets = 2; };
        class VIC_fnc_startMinefieldManager { allowedTargets = 2; };
        class VIC_fnc_spawnAmbushes       { allowedTargets = 2; };
        class VIC_fnc_startAmbushManager  { allowedTargets = 2; };
        class VIC_fnc_startAnomalyManager { allowedTargets = 2; };
        class VIC_fnc_setupMutantHabitats { allowedTargets = 2; };
        class VIC_fnc_spawnCachedHabitats { allowedTargets = 2; };
        class VIC_fnc_manageHabitats      { allowedTargets = 2; };
        class VIC_fnc_triggerAIPanic      { allowedTargets = 2; };
        class VIC_fnc_resetAIBehavior     { allowedTargets = 2; };
        class VIC_fnc_toggleFieldAvoid    { allowedTargets = 2; };
        class VIC_fnc_radioMessage        { allowedTargets = 0; };
        class VIC_fnc_createLocalMarker   { allowedTargets = 0; };
        class CBRN_fnc_spawnMist          { allowedTargets = 0; };
        class VIC_fnc_sendServerState    { allowedTargets = 2; };
        class VIC_fnc_remoteReturn       { allowedTargets = 0; };
        class VIC_fnc_getServerMetrics   { allowedTargets = 2; };
    };

    class Commands
    {
        mode = 2;
        jip = 0;
        class addAction       { allowedTargets = 0; };
    };
};

class Extended_PreInit_EventHandlers
{
    class VIC_StalkerALife_PreInit
    {
        init = "call compile preprocessFileLineNumbers 'vic\initServer.sqf'";
    };
};

class Extended_PostInit_EventHandlers
{
    class VIC_StalkerALife_PostInit
    {
        init = "call compile preprocessFileLineNumbers 'VIC\initServer.sqf'";
    };
};
