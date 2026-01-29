class CfgPatches
{
    class VIC_StalkerALife_Spooks
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

        class Spooks
        {
            file = "vicstalker_spooks\functions\spooks";
            class setupSpookZones{};
            class spawnSpookZone{};
            class manageSpookZones{};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_spawnSpookZone      { allowedTargets = 2; };
    };
};
