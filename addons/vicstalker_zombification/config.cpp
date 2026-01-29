class CfgPatches
{
    class VIC_StalkerALife_Zombification
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

        class Zombification
        {
            file = "vicstalker_zombification\functions\zombification";
            class spawnZombiesFromQueue{};
            class trackDeadForZombify{};
            class onEmissionEnd{};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_spawnZombiesFromQueue { allowedTargets = 2; };
    };
};
