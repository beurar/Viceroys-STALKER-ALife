class CfgPatches
{
    class VIC_StalkerALife_Anomalies
    {
        requiredVersion = 2.02;
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "VIC_StalkerALife_Core"
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

        class Anomalies
        {
            file = "vicstalker_anomalies\functions\anomalies";
            class spawnAllAnomalyFields{};
            class spawnBridgeAnomalyFields{};
            class cleanupAnomalyMarkers{};
            class manageAnomalyFields{};
            class startAnomalyManager{};
            class activateSite{};
            class deactivateSite{};
            class cycleAnomalyFields{};
            class onEmissionBuildUp{};
            class onEmissionStart{};
            class onEmissionEnd{};
            class setupAnomalyFields{};
            class generateFieldName{};
        };

        class AnomalyFields
        {
            file = "vicstalker_anomalies\functions\anomalies\fields";
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
            file = "vicstalker_anomalies\functions\anomalies\find_sites";
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
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_spawnAllAnomalyFields    { allowedTargets = 2; };
        class VIC_fnc_spawnBridgeAnomalyFields { allowedTargets = 2; };
        class VIC_fnc_cycleAnomalyFields  { allowedTargets = 2; };
        class VIC_fnc_startAnomalyManager { allowedTargets = 2; };
    };
};
