class CfgPatches
{
    class VIC_StalkerALife_Chemical
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

        class Chemical
        {
            file = "vicstalker_chemical\functions\chemical";
            class cleanupChemicalZones{};
            class spawnChemicalZone{};
            class spawnRandomChemicalZones{};
            class spawnValleyChemicalZones{};
            class spawnValleyChemicalFields{};
            class activateSite{};
            class deactivateSite{};
            class expandValley{};
            class findValleyPosition{};
            class onEmissionStart{};
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
        class VIC_fnc_spawnChemicalZone   { allowedTargets = 2; };
        class VIC_fnc_spawnRandomChemicalZones { allowedTargets = 2; };
        class VIC_fnc_spawnValleyChemicalZones { allowedTargets = 2; };
        class VIC_fnc_spawnValleyChemicalFields { allowedTargets = 2; };
    };
};
