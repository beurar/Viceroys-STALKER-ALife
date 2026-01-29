class CfgPatches
{
    class VIC_StalkerALife_Storms
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

        class Storms
        {
            file = "vicstalker_storms\functions\storms";
            class schedulePsyStorms{};
            class triggerPsyStorm{};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_triggerPsyStorm     { allowedTargets = 2; };
    };
};
