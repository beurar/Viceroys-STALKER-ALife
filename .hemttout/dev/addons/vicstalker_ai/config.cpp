class CfgPatches
{
    class VIC_StalkerALife_AI
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

        class AI
        {
            file = "vicstalker_ai\functions\ai";
            class resetAIBehavior{};
            class triggerAIPanic{};
            class avoidAnomalies{};
            class avoidAnomalyFields{};
            class toggleFieldAvoid{};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_triggerAIPanic      { allowedTargets = 2; };
        class VIC_fnc_resetAIBehavior     { allowedTargets = 2; };
        class VIC_fnc_toggleFieldAvoid    { allowedTargets = 2; };
    };
};
