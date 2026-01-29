class CfgPatches
{
    class VIC_StalkerALife_Antistasi
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

        class Antistasi
        {
            file = "vicstalker_antistasi\functions\antistasi";
            class isAntistasiUltimate{};
            class startMutantHunt{};
            class startArtefactHunt{};
            class startChemSample{};
            class completeArtefactHunt{};
            class completeChemSample{};
            class disableWeather{};
        };
    };
};
