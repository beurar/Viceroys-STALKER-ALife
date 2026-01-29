class CfgPatches
{
    class VIC_StalkerALife_Mutants
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

        class Mutants
        {
            file = "vicstalker_mutants\functions\mutants";
            class spawnAmbientHerds{};
            class spawnMutantGroup{};
            class spawnMutantNest{};
            class spawnBloodsuckerNest{};
            class spawnBoarNest{};
            class spawnCatNest{};
            class spawnFleshNest{};
            class spawnBlindDogNest{};
            class spawnPseudodogNest{};
            class spawnSnorkNest{};
            class spawnControllerNest{};
            class spawnPseudogiantNest{};
            class spawnIzlomNest{};
            class spawnCorruptorNest{};
            class spawnSmasherNest{};
            class spawnAcidSmasherNest{};
            class spawnBehemothNest{};
            class isMutantEnabled{};
            class manageHerds{};
            class manageHostiles{};
            class manageNests{};
            class manageHabitats{};
            class setupMutantHabitats{};
            class spawnCachedHabitats{};
            class spawnPredatorAttack{};
            class spawnHabitatHunters{};
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
        class VIC_fnc_spawnMutantGroup    { allowedTargets = 2; };
        class VIC_fnc_spawnAmbientHerds   { allowedTargets = 2; };
        class VIC_fnc_setupMutantHabitats { allowedTargets = 2; };
        class VIC_fnc_spawnCachedHabitats { allowedTargets = 2; };
        class VIC_fnc_manageHabitats      { allowedTargets = 2; };
        class VIC_fnc_spawnPredatorAttack { allowedTargets = 2; };
        class VIC_fnc_spawnHabitatHunters { allowedTargets = 2; };
    };
};
