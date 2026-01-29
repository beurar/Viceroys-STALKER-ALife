/*
    Returns true if the specified mutant type is enabled via CBA settings.

    Params:
        0: STRING - mutant type name (e.g. "Bloodsucker")

    Returns:
        BOOL - whether the mutant is enabled
*/
params ["_type"];

private _setting = switch (_type) do {
    case "Bloodsucker": {"VSA_enableBloodsucker"};
    case "Boar": {"VSA_enableBoar"};
    case "Cat": {"VSA_enableCat"};
    case "Flesh": {"VSA_enableFlesh"};
    case "Blind Dog": {"VSA_enableBlindDog"};
    case "Pseudodog": {"VSA_enablePseudodog"};
    case "Snork": {"VSA_enableSnork"};
    case "Controller": {"VSA_enableController"};
    case "Pseudogiant": {"VSA_enablePseudogiant"};
    case "Izlom": {"VSA_enableIzlom"};
    case "Corruptor": {"VSA_enableCorruptor"};
    case "Smasher": {"VSA_enableSmasher"};
    case "Acid Smasher": {"VSA_enableAcidSmasher"};
    case "Behemoth": {"VSA_enableBehemoth"};
    case "Parasite": {"VSA_enableParasite"};
    case "Jumper": {"VSA_enableJumper"};
    case "Spitter": {"VSA_enableSpitter"};
    case "Stalker": {"VSA_enableStalker"};
    case "Bully": {"VSA_enableBully"};
    case "Hivemind": {"VSA_enableHivemind"};
    case "Zombie": {"VSA_enableZombie"};
    case "Chimera": {"VSA_enableChimera"};
    default {""};
};
if (_setting isEqualTo "") exitWith { true };
[_setting, true] call VIC_fnc_getSetting;
