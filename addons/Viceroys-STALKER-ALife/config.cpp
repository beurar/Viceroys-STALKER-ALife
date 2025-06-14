class CfgPatches
{
    class VIC_StalkerALife
    {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Functions_F",
            "CBA_Extended_EventHandlers",
            "cba_main",
            "diwako_anomalies_main"
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
            file = "Viceroys-STALKER-ALife\functions\core";
            class masterInit{};
            class registerEmissionHooks{};
            class getSetting{};
            class getSurfacePosition{};
            class hasPlayersNearby{};
            class createGlobalMarker{};
            class weightedPick{};
            class selectWeightedBuilding{};
            class findBridges{};
            class radioMessage{};
        };

        class AI
        {
            file = "Viceroys-STALKER-ALife\functions\ai";
            class resetAIBehavior{};
            class triggerAIPanic{};
            class avoidAnomalies{};
            class avoidAnomalyFields{};
            class toggleFieldAvoid{};
        };

        class Panic
        {
            file = "Viceroys-STALKER-ALife\functions\panic";
            class onEmissionBuildUp{};
            class onEmissionStart{};
            class onEmissionEnd{};
        };

        class Mutants
        {
            file = "Viceroys-STALKER-ALife\functions\mutants";
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
            class manageHerds{};
            class manageHostiles{};
            class manageNests{};
            class manageHabitats{};
            class setupMutantHabitats{};
            class onEmissionStart{};
            class onEmissionEnd{};
        };
        class Stalkers
        {
            file = "Viceroys-STALKER-ALife\functions\stalkers";
            class spawnAmbientStalkers{};
            class spawnStalkerCamp{};
            class spawnStalkerCamps{};
            class manageStalkerCamps{};
        };


        class Chemical
        {
            file = "Viceroys-STALKER-ALife\functions\chemical";
            class cleanupChemicalZones{};
            class spawnChemicalZone{};
            class spawnRandomChemicalZones{};
            class onEmissionStart{};
            class onEmissionEnd{};
        };

        class Spooks
        {
            file = "Viceroys-STALKER-ALife\functions\spooks";
            class setupSpookZones{};
            class spawnSpookZone{};
        };
        class Minefields
        {
            file = "Viceroys-STALKER-ALife\functions\minefields";
            class spawnMinefields{};
            class spawnAPERSField{};
            class spawnIED{};
            class manageMinefields{};
            class startMinefieldManager{};
        };
        class Wrecks
        {
            file = "Viceroys-STALKER-ALife\functions\wrecks";
            class spawnAbandonedVehicles{};
        };

        class Ambushes
        {
            file = "Viceroys-STALKER-ALife\functions\ambushes";
            class spawnAmbushes{};
            class manageAmbushes{};
            class startAmbushManager{};
        };
        class Blowouts
        {
            file = "Viceroys-STALKER-ALife\functions\blowouts";
            class scheduleBlowouts{};
            class triggerBlowout{};
            class placeTownSirens{};
        };

        class Storms
        {
            file = "Viceroys-STALKER-ALife\functions\storms";
            class schedulePsyStorms{};
            class triggerPsyStorm{};
        };

        class Zombification
        {
            file = "Viceroys-STALKER-ALife\functions\zombification";
            class spawnZombiesFromQueue{};
            class trackDeadForZombify{};
            class onEmissionEnd{};
        };

        class Anomalies
        {
            file = "Viceroys-STALKER-ALife\functions\anomalies";
            class spawnAllAnomalyFields{};
            class cleanupAnomalyMarkers{};
            class manageAnomalyFields{};
            class onEmissionBuildUp{};
            class onEmissionStart{};
            class onEmissionEnd{};
        };

        class AnomalyFields
        {
            file = "Viceroys-STALKER-ALife\functions\anomalies\fields";
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
            class createField_bridgeElectra{};
        };

        class AnomalyFindSites
        {
            file = "Viceroys-STALKER-ALife\functions\anomalies\find_sites";
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
            class findSite_bridge{};
        };

        class Antistasi
        {
            file = "Viceroys-STALKER-ALife\functions\antistasi";
            class isAntistasiUltimate{};
            class startMutantHunt{};
            class startArtefactHunt{};
            class startChemSample{};
            class completeArtefactHunt{};
            class completeChemSample{};
        };
    };
};

class Extended_PreInit_EventHandlers
{
    class VIC_StalkerALife_PreInit
    {
        init = "call compile preprocessFileLineNumbers '\Viceroys-STALKER-ALife\functions\core\fn_masterInit.sqf'";
    };
};
