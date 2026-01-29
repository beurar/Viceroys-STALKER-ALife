class CfgPatches
{
    class VIC_StalkerALife_Core
    {
        requiredVersion = 2.02;
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Functions_F",
            "CBA_Extended_EventHandlers",
            "cba_main"
        };
        author = "Viceroy";
        version = "1.0";
    };
};

class CfgFunctions
{
    class VIC
    {
        tag = "VIC";

        class Core
        {
            file = "vicstalker_core\functions\core";
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
            class findBeachesInMap{};
            class findBridges{};
            class findBuildingClusters{};
            class debugLog{};
            class evalSiteProximity{};
            class radioMessage{};
            class sitePlaced{};
            class activateSite{};
            class deactivateSite{};
            class requestServerState{};
            class sendServerState{};
            class applyServerState{};
            class callServer{};
            class callServerHelper{};
            class getServerMetrics{};
            class markSitesOverlay{};
            class toggleSiteOverlay{};
            class togglePerfMetrics{};
        };
    };
};

class Extended_PreInit_EventHandlers
{
    class VIC_StalkerALife_PreInit
    {
        init = "call compile preprocessFileLineNumbers 'vicstalker\core\functions\core\fn_masterInit.sqf'";
    };
};

class Extended_PostInit_EventHandlers
{
    class VIC_StalkerALife_PostInit
    {
        init = "call compile preprocessFileLineNumbers 'vicstalker\core\initServer.sqf'";
    };
};
