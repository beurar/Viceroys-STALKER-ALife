class CfgPatches
{
    class VIC_StalkerALife_Stalkers
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

        class Stalkers
        {
            file = "vicstalker_stalkers\functions\stalkers";
            class spawnAmbientStalkers{};
            class spawnStalkerCamp{};
            class spawnStalkerCamps{};
            class findCampBuilding{};
            class spawnFlareTripwires{};
            class spawnSniper{};
            class manageSnipers{};
            class startSniperManager{};
            class startCampManager{};
            class manageStalkerCamps{};
            class manageWanderers{};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_spawnAmbientStalkers { allowedTargets = 2; };
        class VIC_fnc_spawnStalkerCamps   { allowedTargets = 2; };
        class VIC_fnc_spawnSniper         { allowedTargets = 2; };
        class VIC_fnc_startSniperManager  { allowedTargets = 2; };
        class VIC_fnc_startCampManager   { allowedTargets = 2; };
    };
};
