class CfgPatches
{
    class VIC_StalkerALife_Wrecks
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

        class Wrecks
        {
            file = "vicstalker_wrecks\functions\wrecks";
            class spawnAbandonedVehicles{};
            class findWrecks{};
            class manageWrecks{};
        };
    };
};
