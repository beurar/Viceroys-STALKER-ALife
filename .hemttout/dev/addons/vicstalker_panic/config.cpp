class CfgPatches
{
    class VIC_StalkerALife_Panic
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

        class Panic
        {
            file = "vicstalker_panic\functions\panic";
            class onEmissionBuildUp{};
            class onEmissionStart{};
            class onEmissionEnd{};
        };
    };
};
