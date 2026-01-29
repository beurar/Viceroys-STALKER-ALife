class CfgPatches
{
    class VIC_StalkerALife_Necroplague
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

        class Necroplague
        {
            file = "vicstalker_necroplague\functions\necroplague";
            class triggerNecroplague{};
            class scheduleNecroplague{};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_triggerNecroplague  { allowedTargets = 2; };
    };
};
