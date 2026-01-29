class CfgPatches
{
    class VIC_StalkerALife_Minefields
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

        class Minefields
        {
            file = "vicstalker_minefields\functions\minefields";
            class spawnMinefields{};
            class spawnAPERSField{};
            class spawnIED{};
            class spawnIEDSites{};
            class manageIEDSites{};
            class startIEDManager{};
            class spawnBoobyTraps{};
            class spawnTripwirePerimeter{};
            class activateSite{};
            class deactivateSite{};
            class manageMinefields{};
            class manageBoobyTraps{};
            class startMinefieldManager{};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class VIC_fnc_spawnMinefields     { allowedTargets = 2; };
        class VIC_fnc_spawnIEDSites       { allowedTargets = 2; };
        class VIC_fnc_startIEDManager     { allowedTargets = 2; };
        class VIC_fnc_spawnBoobyTraps     { allowedTargets = 2; };
        class VIC_fnc_spawnTripwirePerimeter { allowedTargets = 2; };
        class VIC_fnc_startMinefieldManager { allowedTargets = 2; };
    };
};
