class CfgPatches
{
    class VIC_StalkerALife_Ambushes
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

        class Ambushes
        {
            file = "vicstalker_ambushes\functions\ambushes";
            class spawnAmbushes{};
            class manageAmbushes{};
            class startAmbushManager{};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_spawnAmbushes       { allowedTargets = 2; };
        class VIC_fnc_startAmbushManager  { allowedTargets = 2; };
    };
};
