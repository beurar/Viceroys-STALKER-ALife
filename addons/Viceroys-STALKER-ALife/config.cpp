class CfgPatches
{
    class VIC_StalkerALife
    {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"A3_Functions_F"};
    };
};

class CfgFunctions
{
    class VIC
    {
        tag = "VIC";

        class Core
        {
            file = "functions/core";
            class masterInit{};
            class registerEmissionHooks{};
            class hasPlayersNearby{};
        };

        class AI
        {
            file = "functions/ai";
            class resetAIBehavior{};
            class triggerAIPanic{};
        };

        class Mutants
        {
            file = "functions/mutants";
            class spawnAmbientHerds{};
            class spawnMutantGroup{};
            class setupMutantHabitats{};
        };

        class Radiation
        {
            file = "functions/radiation";
            class cleanupRadiationZones{};
            class spawnRadiationZone{};
            class spawnRandomRadiationZones{};
        };

        class Spooks
        {
            file = "functions/spooks";
            class setupSpookZones{};
            class spawnSpookZone{};
        };

        class Storms
        {
            file = "functions/storms";
            class schedulePsyStorms{};
            class triggerPsyStorm{};
        };

        class Zombification
        {
            file = "functions/zombification";
            class spawnZombiesFromQueue{};
            class trackDeadForZombify{};
        };

        class Anomalies
        {
            file = "functions/anomalies";
            class spawnAllAnomalyFields{};
        };

        class AnomalyFields
        {
            file = "functions/anomalies/fields";
            class createField_burner{};
            class createField_clicker{};
            class createField_electra{};
            class createField_fruitpunch{};
            class createField_gravi{};
            class createField_meatgrinder{};
            class createField_springboard{};
            class createField_whirligig{};
        };

        class AnomalyFindSites
        {
            file = "functions/anomalies/find_sites";
            class findSite_burner{};
            class findSite_clicker{};
            class findSite_electra{};
            class findSite_fruitpunch{};
            class findSite_gravi{};
            class findSite_meatgrinder{};
            class findSite_springboard{};
            class findSite_whirligig{};
        };
    };
};

class Extended_PreInit_EventHandlers
{
    class VIC_StalkerALife_PreInit
    {
        init = "call compile preprocessFileLineNumbers 'functions/core/fn_masterInit.sqf'";
    };
};