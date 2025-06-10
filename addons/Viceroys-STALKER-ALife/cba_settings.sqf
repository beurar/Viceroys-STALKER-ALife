// CBA settings configuration for Viceroy's STALKER ALife

// -----------------------------------------------------------------------------
// Emission
// -----------------------------------------------------------------------------
[
    "VSA_AIPanicEnabled",
    "CHECKBOX",
    ["Enable AI Emission Panic", "AI units will attempt to find cover indoors or in trenches when an emission is building up."],
    "Viceroy's STALKER ALife - Emission",
    true
] call CBA_fnc_addSetting;





/*
    cba_settings.sqf
    Registers addon options for Viceroys STALKER ALife.
    Each subsystem exposes basic options such as toggles,
    counts, spawn weights and night-only behaviour.
*/

// -----------------------------------------------------------------------------
// Anomalies
// -----------------------------------------------------------------------------
[
    "VSA_enableAnomalies",
    "CHECKBOX",
    ["Enable Anomaly Fields", "Toggle anomaly field spawning"],
    "Viceroy's STALKER ALife - Anomalies",
    true
] call CBA_fnc_addSetting;

[
    "VSA_anomalyFieldCount",
    "SLIDER",
    ["Anomaly Fields per Area", "Number of fields spawned per area"],
    "Viceroy's STALKER ALife - Anomalies",
    [3, 0, 10, 0]
] call CBA_fnc_addSetting;

[
    "VSA_maxAnomalyFields",
    "SLIDER",
    ["Max Active Fields", "Maximum number of anomaly fields present at once"],
    "Viceroy's STALKER ALife - Anomalies",
    [20, 0, 100, 0]
] call CBA_fnc_addSetting;

[
    "VSA_anomalySpawnWeight",
    "SLIDER",
    ["Anomaly Spawn Weight", "Relative spawn chance of anomaly types"],
    "Viceroy's STALKER ALife - Anomalies",
    [50, 0, 100, 0]
] call CBA_fnc_addSetting;

[
    "VSA_anomalyNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Anomalies only spawn at night"],
    "Viceroy's STALKER ALife - Anomalies",
    false
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Radiation
// -----------------------------------------------------------------------------
[
    "VSA_enableRadiation",
    "CHECKBOX",
    ["Enable Radiation Zones", "Toggle radiation zone spawning"],
    "Viceroy's STALKER ALife - Radiation",
    true
] call CBA_fnc_addSetting;

[
    "VSA_radiationZoneCount",
    "SLIDER",
    ["Radiation Zones per Area", "Number of radiation zones created"],
    "Viceroy's STALKER ALife - Radiation",
    [2, 0, 10, 0]
] call CBA_fnc_addSetting;

[
    "VSA_radiationSpawnWeight",
    "SLIDER",
    ["Radiation Spawn Weight", "Relative chance for radiation zone creation"],
    "Viceroy's STALKER ALife - Radiation",
    [50, 0, 100, 0]
] call CBA_fnc_addSetting;

[
    "VSA_radiationNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Radiation zones only appear at night"],
    "Viceroy's STALKER ALife - Radiation",
    false
] call CBA_fnc_addSetting;

[
    "VSA_emissionRadiationCount",
    "SLIDER",
    ["Zones After Emission", "Radiation zones spawned after an emission"],
    "VSA - Radiation",
    [2, 0, 10, 0]
] call CBA_fnc_addSetting;

[
    "VSA_emissionRadiationRadius",
    "SLIDER",
    ["Emission Radiation Radius", "Search radius around players for emission zones"],
    "VSA - Radiation",
    [300, 50, 2000, 0]
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Mutants
// -----------------------------------------------------------------------------
[
    "VSA_enableMutants",
    "CHECKBOX",
    ["Enable Mutants", "Toggle mutant spawning"],
    "Viceroy's STALKER ALife - Mutants",
    true
] call CBA_fnc_addSetting;

[
    "VSA_mutantGroupCount",
    "SLIDER",
    ["Mutant Groups per Area", "Number of mutant groups"],
    "Viceroy's STALKER ALife - Mutants",
    [3, 0, 20, 0]
] call CBA_fnc_addSetting;

[
    "VSA_mutantSpawnWeight",
    "SLIDER",
    ["Mutant Spawn Weight", "Relative chance for mutant spawns"],
    "Viceroy's STALKER ALife - Mutants",
    [50, 0, 100, 0]
] call CBA_fnc_addSetting;

[
    "VSA_mutantsNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Mutants only spawn at night"],
    "Viceroy's STALKER ALife - Mutants",
    false
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Spooks
// -----------------------------------------------------------------------------
[
    "VSA_enableSpooks",
    "CHECKBOX",
    ["Enable Spook Zones", "Toggle paranormal event spawning"],
    "Viceroy's STALKER ALife - Spooks",
    true
] call CBA_fnc_addSetting;

[
    "VSA_spookZoneCount",
    "SLIDER",
    ["Spook Zones per Area", "Number of paranormal zones"],
    "Viceroy's STALKER ALife - Spooks",
    [1, 0, 10, 0]
] call CBA_fnc_addSetting;

[
    "VSA_spookSpawnWeight",
    "SLIDER",
    ["Spook Spawn Weight", "Relative chance for spook events"],
    "Viceroy's STALKER ALife - Spooks",
    [50, 0, 100, 0]
] call CBA_fnc_addSetting;

[
    "VSA_spooksNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Spooks are active only at night"],
    "Viceroy's STALKER ALife - Spooks",
    true
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Storms
// -----------------------------------------------------------------------------
[
    "VSA_enableStorms",
    "CHECKBOX",
    ["Enable Psy-Storms", "Toggle psy-storm events"],
    "Viceroy's STALKER ALife - Storms",
    true
] call CBA_fnc_addSetting;

[
    "VSA_stormInterval",
    "SLIDER",
    ["Storm Interval (min)", "Minutes between possible storms"],
    "Viceroy's STALKER ALife - Storms",
    [30, 5, 120, 0]
] call CBA_fnc_addSetting;

[
    "VSA_stormSpawnWeight",
    "SLIDER",
    ["Storm Spawn Weight", "Relative chance for a storm to occur"],
    "Viceroy's STALKER ALife - Storms",
    [50, 0, 100, 0]
] call CBA_fnc_addSetting;

[
    "VSA_stormsNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Storms only trigger at night"],
    "Viceroy's STALKER ALife - Storms",
    false
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Zombification
// -----------------------------------------------------------------------------
[
    "VSA_enableZombification",
    "CHECKBOX",
    ["Enable Zombification", "Toggle NPC zombification mechanics"],
    "Viceroy's STALKER ALife - Zombification",
    true
] call CBA_fnc_addSetting;

[
    "VSA_zombieCount",
    "SLIDER",
    ["Max Zombies", "Maximum zombies spawned from bodies"],
    "Viceroy's STALKER ALife - Zombification",
    [15, 0, 100, 0]
] call CBA_fnc_addSetting;

[
    "VSA_zombieSpawnWeight",
    "SLIDER",
    ["Zombie Spawn Weight", "Relative chance that dead bodies zombify"],
    "Viceroy's STALKER ALife - Zombification",
    [50, 0, 100, 0]
] call CBA_fnc_addSetting;

[
    "VSA_zombiesNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Bodies zombify only at night"],
    "Viceroy's STALKER ALife - Zombification",
    false
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// AI Behaviour
// -----------------------------------------------------------------------------
[
    "VSA_enableAIBehaviour",
    "CHECKBOX",
    ["Enable AI Behaviour Tweaks", "Toggle custom AI behaviour"],
    "Viceroy's STALKER ALife - AI",
    true
] call CBA_fnc_addSetting;

[
    "VSA_panicThreshold",
    "SLIDER",
    ["AI Panic Threshold", "Chance for AI to panic when threatened"],
    "Viceroy's STALKER ALife - AI",
    [50, 0, 100, 0]
] call CBA_fnc_addSetting;

[
    "VSA_aiNightOnly",
    "CHECKBOX",
    ["Night Time Only", "AI tweaks only active at night"],
    "Viceroy's STALKER ALife - AI",
    false
] call CBA_fnc_addSetting;


// Hostile mutant spawns
["VSA_mutantGroupCountHostile", "SLIDER", [1, 5, 1], 1, "Number of mutant groups after an emission"] call CBA_fnc_addSetting;
["VSA_mutantThreat", "SLIDER", [1, 10, 1], 3, "Units per hostile group"] call CBA_fnc_addSetting;
["VSA_mutantNightOnlyHostile", "CHECKBOX", false, "Spawn hostile groups only at night"] call CBA_fnc_addSetting;

// Ambient herds
["VSA_ambientHerdCount", "SLIDER", [0, 5, 1], 2, "Number of roaming herds"] call CBA_fnc_addSetting;
["VSA_ambientHerdSize", "SLIDER", [1, 8, 1], 4, "Units per roaming herd"] call CBA_fnc_addSetting;
["VSA_ambientNightOnly", "CHECKBOX", false, "Spawn herds only at night"] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Debug
// -----------------------------------------------------------------------------
[
    "VSA_debugMode",
    "CHECKBOX",
    ["Enable Debug Mode", "Show on-screen logs and enable testing actions"],
    "Viceroy's STALKER ALife - Debug",
    false
] call CBA_fnc_addSetting;
