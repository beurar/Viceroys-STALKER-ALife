class CfgPatches
{
    class VIC_StalkerALife_Blowouts
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

        class Blowouts
        {
            file = "vicstalker_blowouts\functions\blowouts";
            class scheduleBlowouts{};
            class triggerBlowout{};
            class placeTownSirens{};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_triggerBlowout      { allowedTargets = 2; };
    };
};
